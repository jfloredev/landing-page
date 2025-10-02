# Docker Setup para React Landing Page

Este proyecto incluye configuración completa de Docker para desarrollo y producción.

## 🐳 Estructura Docker

- **Dockerfile**: Multi-stage build para producción con Nginx
- **Dockerfile.dev**: Imagen optimizada para desarrollo
- **docker-compose.yml**: Orquestación de servicios
- **nginx.conf**: Configuración personalizada de Nginx

## 🚀 Comandos Rápidos

### Desarrollo con Docker

```bash
# Construir y ejecutar en modo desarrollo
npm run docker:dev

# O manualmente:
docker-compose --profile dev up --build
```

### Producción con Docker

```bash
# Construir y ejecutar en modo producción
npm run docker:prod

# O manualmente:
docker-compose --profile prod up --build -d
```

### Comandos Docker directos

```bash
# Construir imagen de producción
npm run docker:build

# Construir imagen de desarrollo
npm run docker:build-dev

# Ejecutar contenedor de producción
npm run docker:run

# Ejecutar contenedor de desarrollo
npm run docker:run-dev

# Parar todos los contenedores
npm run docker:stop
```

## 📦 Características Docker

### Imagen de Producción
- **Multi-stage build** para optimización de tamaño
- **Nginx Alpine** como servidor web (solo ~5MB base)
- **Compresión Gzip** habilitada
- **Headers de seguridad** configurados
- **Health checks** incluidos
- **Cache optimizado** para assets estáticos

### Imagen de Desarrollo  
- **Hot reload** con volúmenes montados
- **Node.js 18 Alpine** para desarrollo
- **Puerto 3000** expuesto
- **Polling activado** para mejor compatibilidad

## 🔧 Configuración Avanzada

### Variables de Entorno

Puedes crear un archivo `.env` para configurar variables:

```env
# .env
VITE_API_URL=https://jsonplaceholder.typicode.com
VITE_APP_TITLE=Mi Landing Page
```

### Escalado Horizontal

Para escalar la aplicación:

```bash
# Escalar a 3 instancias
docker-compose --profile prod up --scale app-prod=3 -d
```

### Monitoreo y Logs

```bash
# Ver logs en tiempo real
docker-compose logs -f app-prod

# Ver logs específicos
docker logs <container-id>

# Inspeccionar contenedor
docker exec -it <container-id> sh
```

## 📊 Optimizaciones Incluidas

### Nginx
- Compresión Gzip automática
- Cache de assets estáticos (1 año)
- Headers de seguridad
- Manejo de SPA routing
- Health check endpoint

### Build de Producción  
- Code splitting automático
- Chunks separados para vendor y axios
- Sourcemaps deshabilitados en producción
- Optimización de assets

## 🔒 Seguridad

- Contenedores non-root por defecto
- Headers de seguridad configurados
- No exposición de código fuente en producción
- Imagen minimal Alpine Linux

## 🌐 Despliegue en AWS

### Opción 1: AWS ECS con ECR

```bash
# 1. Crear repositorio ECR
aws ecr create-repository --repository-name react-landing-page

# 2. Obtener login token
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <account-id>.dkr.ecr.us-east-1.amazonaws.com

# 3. Construir y tagear imagen
docker build -t react-landing-page .
docker tag react-landing-page:latest <account-id>.dkr.ecr.us-east-1.amazonaws.com/react-landing-page:latest

# 4. Subir imagen
docker push <account-id>.dkr.ecr.us-east-1.amazonaws.com/react-landing-page:latest
```

### Opción 2: AWS App Runner

1. Sube tu código a GitHub
2. Conecta App Runner con tu repositorio
3. App Runner detectará automáticamente el Dockerfile
4. Configura el puerto 80 en la configuración

### Opción 3: AWS Lightsail Containers

```bash
# Subir imagen a Lightsail
aws lightsail push-container-image --service-name react-landing-page --label react-app --image react-landing-page:latest
```

## 🚀 CI/CD con GitHub Actions

Ejemplo de workflow para despliegue automático:

```yaml
# .github/workflows/deploy.yml
name: Deploy to AWS
on:
  push:
    branches: [main]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v2
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-1
      - name: Build and push Docker image
        run: |
          aws ecr get-login-password | docker login --username AWS --password-stdin $ECR_REGISTRY
          docker build -t $ECR_REPOSITORY .
          docker tag $ECR_REPOSITORY:$IMAGE_TAG $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG
          docker push $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG
```

## 📋 Troubleshooting

### Problemas Comunes

**Puerto en uso:**
```bash
# Matar procesos en puerto 3000/80
sudo lsof -ti:3000 | xargs kill -9
sudo lsof -ti:80 | xargs kill -9
```

**Problemas de permisos:**
```bash
# Dar permisos a Docker socket (Linux)
sudo usermod -aG docker $USER
```

**Hot reload no funciona:**
- Asegúrate de que `usePolling: true` esté en vite.config.js
- Verifica que los volúmenes estén correctamente montados

**Imagen muy grande:**
```bash
# Analizar capas de la imagen
docker history react-landing-page

# Limpiar imágenes no utilizadas
docker system prune -a
```

¡Tu aplicación React ahora está completamente dockerizada y lista para desplegar! 🎉
