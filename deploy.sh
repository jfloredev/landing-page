#!/bin/bash

# Deploy script para React Landing Page
# Soporta múltiples plataformas de despliegue

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para mostrar ayuda
show_help() {
    echo -e "${BLUE}🚀 Script de Despliegue - React Landing Page${NC}"
    echo ""
    echo "Uso: ./deploy.sh [PLATAFORMA] [OPCIONES]"
    echo ""
    echo "Plataformas disponibles:"
    echo "  amplify    - AWS Amplify (Hosting estático)"
    echo "  ecs        - AWS ECS con Docker"
    echo "  apprunner  - AWS App Runner"
    echo "  lightsail  - AWS Lightsail Containers"
    echo "  docker     - Build local Docker"
    echo ""
    echo "Opciones:"
    echo "  -h, --help     Mostrar esta ayuda"
    echo "  -v, --verbose  Output verbose"
    echo ""
    echo "Ejemplos:"
    echo "  ./deploy.sh amplify"
    echo "  ./deploy.sh docker"
    echo "  ./deploy.sh ecs --verbose"
}

# Función para verificar dependencias
check_dependencies() {
    echo -e "${YELLOW}🔍 Verificando dependencias...${NC}"
    
    # Verificar Node.js
    if ! command -v node &> /dev/null; then
        echo -e "${RED}❌ Node.js no está instalado${NC}"
        exit 1
    fi
    
    # Verificar npm
    if ! command -v npm &> /dev/null; then
        echo -e "${RED}❌ npm no está instalado${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}✅ Dependencias básicas verificadas${NC}"
}

# Función para build de producción
build_production() {
    echo -e "${YELLOW}🔨 Construyendo aplicación para producción...${NC}"
    
    npm install
    npm run build
    
    if [ -d "dist" ]; then
        echo -e "${GREEN}✅ Build completado exitosamente${NC}"
    else
        echo -e "${RED}❌ Error en el build${NC}"
        exit 1
    fi
}

# Despliegue en AWS Amplify
deploy_amplify() {
    echo -e "${BLUE}🚀 Desplegando en AWS Amplify...${NC}"
    
    check_dependencies
    
    # Verificar AWS CLI
    if ! command -v aws &> /dev/null; then
        echo -e "${RED}❌ AWS CLI no está instalado${NC}"
        echo "Instala AWS CLI: https://aws.amazon.com/cli/"
        exit 1
    fi
    
    # Verificar Amplify CLI
    if ! command -v amplify &> /dev/null; then
        echo -e "${YELLOW}📦 Instalando Amplify CLI...${NC}"
        npm install -g @aws-amplify/cli
    fi
    
    # Inicializar proyecto si no existe
    if [ ! -f "amplify/.config/project-config.json" ]; then
        echo -e "${YELLOW}🔧 Inicializando proyecto Amplify...${NC}"
        amplify init --yes
    fi
    
    # Agregar hosting si no existe
    if [ ! -d "amplify/backend/hosting" ]; then
        echo -e "${YELLOW}🌐 Configurando hosting...${NC}"
        amplify add hosting
    fi
    
    # Publicar
    echo -e "${BLUE}📤 Publicando aplicación...${NC}"
    amplify publish --yes
    
    echo -e "${GREEN}🎉 ¡Despliegue en Amplify completado!${NC}"
}

# Despliegue con Docker local
deploy_docker() {
    echo -e "${BLUE}🐳 Construyendo imagen Docker...${NC}"
    
    check_dependencies
    
    # Verificar Docker
    if ! command -v docker &> /dev/null; then
        echo -e "${RED}❌ Docker no está instalado${NC}"
        echo "Instala Docker: https://docs.docker.com/get-docker/"
        exit 1
    fi
    
    # Verificar que Docker esté corriendo
    if ! docker info &> /dev/null; then
        echo -e "${RED}❌ Docker daemon no está corriendo${NC}"
        echo "Inicia Docker Desktop o el servicio Docker"
        exit 1
    fi
    
    # Build imagen
    echo -e "${YELLOW}🔨 Construyendo imagen Docker...${NC}"
    docker build -t react-landing-page:latest .
    
    # Opcionalmente ejecutar contenedor
    read -p "¿Deseas ejecutar el contenedor ahora? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${BLUE}🚀 Ejecutando contenedor en puerto 80...${NC}"
        docker run -d -p 80:80 --name react-landing-page react-landing-page:latest
        echo -e "${GREEN}✅ Aplicación disponible en http://localhost${NC}"
    fi
    
    echo -e "${GREEN}🎉 ¡Imagen Docker creada exitosamente!${NC}"
}

# Despliegue en AWS ECS
deploy_ecs() {
    echo -e "${BLUE}📦 Desplegando en AWS ECS...${NC}"
    
    check_dependencies
    
    # Verificar AWS CLI
    if ! command -v aws &> /dev/null; then
        echo -e "${RED}❌ AWS CLI no está instalado${NC}"
        exit 1
    fi
    
    # Variables
    AWS_REGION=$(aws configure get region || echo "us-east-1")
    AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
    ECR_REPO_NAME="react-landing-page"
    
    echo -e "${YELLOW}🏗️ Configurando ECR...${NC}"
    
    # Crear repositorio ECR si no existe
    aws ecr describe-repositories --repository-names $ECR_REPO_NAME --region $AWS_REGION || \
    aws ecr create-repository --repository-name $ECR_REPO_NAME --region $AWS_REGION
    
    # Login a ECR
    aws ecr get-login-password --region $AWS_REGION | \
    docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com
    
    # Build y push imagen
    docker build -t $ECR_REPO_NAME .
    docker tag $ECR_REPO_NAME:latest $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO_NAME:latest
    docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO_NAME:latest
    
    echo -e "${GREEN}🎉 ¡Imagen subida a ECR exitosamente!${NC}"
    echo -e "${BLUE}📝 Siguiente paso: Crear servicio ECS con esta imagen:${NC}"
    echo "   $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO_NAME:latest"
}

# Despliegue en AWS App Runner
deploy_apprunner() {
    echo -e "${BLUE}🏃 Desplegando en AWS App Runner...${NC}"
    
    echo -e "${YELLOW}📝 Para App Runner, necesitas:${NC}"
    echo "1. Código en repositorio GitHub/GitLab"
    echo "2. Dockerfile en la raíz (✅ Ya tienes)"
    echo "3. Crear servicio App Runner desde la consola AWS"
    echo ""
    echo -e "${BLUE}🔗 Link directo:${NC}"
    echo "https://console.aws.amazon.com/apprunner/home#/create-service"
    echo ""
    echo -e "${GREEN}✅ Tu aplicación está lista para App Runner${NC}"
}

# Función principal
main() {
    case $1 in
        amplify)
            deploy_amplify
            ;;
        docker)
            deploy_docker
            ;;
        ecs)
            deploy_ecs
            ;;
        apprunner)
            deploy_apprunner
            ;;
        lightsail)
            echo -e "${BLUE}⛵ Para Lightsail Containers, visita:${NC}"
            echo "https://lightsail.aws.amazon.com/ls/webapp/create/container-service"
            ;;
        -h|--help|help)
            show_help
            ;;
        *)
            echo -e "${RED}❌ Plataforma no válida: $1${NC}"
            echo ""
            show_help
            exit 1
            ;;
    esac
}

# Ejecutar función principal
main "$@"
