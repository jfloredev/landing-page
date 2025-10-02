# React Landing Page

Una moderna landing page construida con React y Vite que consume la API pública de JSONPlaceholder para mostrar contenido dinámico.

## 🚀 Características

- **React 18** con hooks modernos
- **Vite** para desarrollo rápido y build optimizado
- **Consumo de API REST** (JSONPlaceholder)
- **Diseño responsivo** con CSS Grid y Flexbox
- **Navegación suave** entre secciones
- **Loading states** y manejo de errores
- **Componentes reutilizables**

## 📦 Instalación

1. Instala las dependencias:
```bash
npm install
```

2. Inicia el servidor de desarrollo:
```bash
npm run dev
```

3. Abre tu navegador en `http://localhost:3000`

## 🛠️ Scripts disponibles

- `npm run dev` - Inicia el servidor de desarrollo
- `npm run build` - Construye la aplicación para producción
- `npm run preview` - Preview de la build de producción
- `npm run lint` - Ejecuta ESLint

## 🌐 API Utilizada

Este proyecto consume la API de [JSONPlaceholder](https://jsonplaceholder.typicode.com/), que proporciona:

- **Posts** - Artículos de ejemplo
- **Users** - Información de usuarios ficticios
- **Comments** - Comentarios asociados a los posts
- **Photos** - Galería de imágenes

## 📁 Estructura del proyecto

```
src/
├── components/
│   ├── Header.jsx          # Encabezado principal
│   ├── Navigation.jsx      # Barra de navegación
│   ├── PostsSection.jsx    # Sección de artículos
│   ├── UsersSection.jsx    # Sección de usuarios
│   ├── StatsSection.jsx    # Estadísticas en tiempo real
│   ├── PostCard.jsx        # Tarjeta individual de post
│   ├── UserCard.jsx        # Tarjeta individual de usuario
│   ├── LoadingSpinner.jsx  # Componente de carga
│   └── Footer.jsx          # Pie de página
├── services/
│   └── api.js              # Configuración y métodos de API
├── App.jsx                 # Componente principal
├── main.jsx               # Punto de entrada
└── index.css              # Estilos globales
```

## 🎨 Funcionalidades

### Secciones principales:

1. **Header** - Introducción con gradiente atractivo
2. **Artículos Recientes** - Muestra los últimos posts de la API
3. **Nuestro Equipo** - Perfiles de usuarios con información detallada
4. **Estadísticas** - Contadores en tiempo real de la API

### Características técnicas:

- **Gestión de estado** con useState y useEffect
- **Llamadas asíncronas** con axios
- **Manejo de errores** y estados de carga
- **Navegación suave** entre secciones
- **Diseño responsivo** para todos los dispositivos

## 🔧 Tecnologías utilizadas

- React 18.2.0
- Vite 4.4.5
- Axios 1.6.0
- CSS3 con Grid y Flexbox
- Google Fonts (Inter)

## 📱 Responsivo

El diseño se adapta perfectamente a:
- 📱 Móviles (< 768px)
- 💻 Tablets (768px - 1024px)
- 🖥️ Desktop (> 1024px)

## 🐳 Docker Support

Este proyecto incluye soporte completo para Docker:

### Desarrollo local con Docker
```bash
# Ejecutar en modo desarrollo
npm run docker:dev

# O con docker-compose
docker-compose --profile dev up --build
```

### Producción con Docker
```bash
# Construir imagen de producción
npm run docker:build

# Ejecutar contenedor de producción
npm run docker:prod
```

### Características Docker:
- **Multi-stage build** para optimización
- **Nginx Alpine** como servidor web
- **Hot reload** en desarrollo
- **Compresión Gzip** habilitada
- **Headers de seguridad** configurados

📖 **Documentación completa de Docker**: Ver [DOCKER.md](./DOCKER.md)

## ☁️ Despliegue en la Nube

### Opciones de Despliegue

#### 1. AWS Amplify (Recomendado para JAMstack)
```bash
# Usando el script de deploy
./deploy.sh amplify

# O manualmente
npm install -g @aws-amplify/cli
amplify init
amplify add hosting
amplify publish
```

#### 2. AWS ECS (Para aplicaciones containerizadas)
```bash
# Usando el script de deploy
./deploy.sh ecs
```

#### 3. AWS App Runner (Más simple)
```bash
./deploy.sh apprunner
```

#### 4. Docker local
```bash
./deploy.sh docker
```

### CI/CD Automático
- **GitHub Actions** configurado para deploy automático
- **Multi-environment** support (dev/staging/prod)
- **Docker builds** automáticos en ECR
- **Tests automáticos** en cada push

### Variables de Entorno Requeridas

Para el despliegue automático, configura estos secrets en GitHub:

```
AWS_ACCESS_KEY_ID=tu_access_key
AWS_SECRET_ACCESS_KEY=tu_secret_key
```

## 🚀 Deploy Rápido

```bash
# Hacer el script ejecutable
chmod +x deploy.sh

# Ver opciones disponibles
./deploy.sh --help

# Deploy en AWS Amplify
./deploy.sh amplify

# Deploy con Docker
./deploy.sh docker
```

¡Disfruta explorando esta landing page moderna con React y Docker! 🎉
