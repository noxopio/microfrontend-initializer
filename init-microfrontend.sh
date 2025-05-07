#!/bin/bash

# Nombre del microfront como argumento
APP_NAME=$1
PORT=$2
file_name="$(basename "$0")"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ -z "$APP_NAME" ]; then
  echo "Uso: ./$file_name nombre-del-microfront"
  exit 1
fi

# Crear estructura base
mkdir "$APP_NAME"
cd "$APP_NAME" || exit

echo "Inicializando proyecto Next.js para $APP_NAME..."

# Inicializa npm y Next.js
# npm init -y
# npm install next react react-dom
# npm install @module-federation/nextjs-mf webpack webpack-cli sass @reduxjs/toolkit react-redux --save-dev
# npm install typescript @types/react @types/node --save-dev

# PROD_DEPENDENCIES=(
#    "@azure/msal-browser": "^3.6.0",
#     "@azure/msal-react": "^2.0.22",
#     "@mantine/core": "7.13.4",
#     "@mantine/hooks": "7.13.4",
#     "@module-federation/nextjs-mf": "^8.8.24",
#     "@reduxjs/toolkit": "^2.2.3",
#     "crypto-js": "^4.2.0",
#     "next": "14.2.7",
#     "pendig-fro-transversal-lib-react": "https://devopsprd.porvenir.net/artifactory/libraries/pendig-fro-transversal-lib-react/pendig-fro-transversal-lib-react-1.2.1.tgz",
#     "react": "18.3.1",
#     "react-dom": "18.3.1",
#     "react-redux": "^9.1.2",
#     "redux": "^5.0.1",
#     "redux-persist": "^6.0.0",
#     "sass": "^1.78.0",
#     "webpack": "^5.94.0"
# )

# # Dependencias de desarrollo
# DEV_DEPENDENCIES=(
#     "@testing-library/jest-dom": "^6.2.0",
#     "@testing-library/react": "^14.1.2",
#     "@testing-library/user-event": "^14.5.2",
#     "@types/jest": "^29.5.14",
#     "@types/node": "^20",
#     "@types/react": "^18",
#     "@types/react-dom": "^18",
#     "cross-env": "^7.0.3",
#     "eslint": "^8.50.0",
#     "eslint-config-next": "14.2.7",
#     "jest": "^29.7.0",
#     "jest-environment-jsdom": "^29.7.0",
#     "jest-fetch-mock": "^3.0.3",
#     "jest-sonar-reporter": "^2.0.0",
#     "msal-react-tester": "^0.3.1",
#     "next-router-mock": "^0.9.13",
#     "postcss": "^8.4.47",
#     "postcss-preset-mantine": "^1.17.0",
#     "postcss-simple-vars": "^7.0.1",
#     "react-select-event": "^5.5.1",
#     "sonar-scanner": "3.1.0",
#     "typescript": "^5"
# )


# # Instalar dependencias de producción
# echo "Instalando dependencias de producción..."
# npm install "${PROD_DEPENDENCIES[@]}"

# # Instalar dependencias de desarrollo
# echo "Instalando dependencias de desarrollo..."
# npm install --save-dev "${DEV_DEPENDENCIES[@]}"

cat <<EOF > package.json
{
  "name": "$APP_NAME",
  "version": "1.0.0",
  "private": true,
  "scripts": {
    "dev":"cross-env NEXT_PRIVATE_LOCAL_WEBPACK=true next dev -p $PORT ",
    "build":"next build",
    "start": "next start",
    "lint": "next lint",
    "test": "jest"
  },
  "dependencies": {
    "@azure/msal-browser": "^3.6.0",
    "@azure/msal-react": "^2.0.22",
    "@mantine/core": "7.13.4",
    "@mantine/hooks": "7.13.4",
    "@module-federation/nextjs-mf": "^8.8.24",
    "@reduxjs/toolkit": "^2.2.3",
    "crypto-js": "^4.2.0",
    "next": "14.2.7",
    
    "react": "18.3.1",
    "react-dom": "18.3.1",
    "react-redux": "^9.1.2",
    "redux": "^5.0.1",
    "redux-persist": "^6.0.0",
    "sass": "^1.78.0",
    "webpack": "^5.94.0"
  },
  "devDependencies": {
    "@testing-library/jest-dom": "^6.2.0",
    "@testing-library/react": "^14.1.2",
    "@testing-library/user-event": "^14.5.2",
    "@types/jest": "^29.5.14",
    "@types/node": "^20",
    "@types/react": "^18",
    "@types/react-dom": "^18",
    "cross-env": "^7.0.3",
    "eslint": "^8.50.0",
    "eslint-config-next": "14.2.7",
    "jest": "^29.7.0",
    "jest-environment-jsdom": "^29.7.0",
    "jest-fetch-mock": "^3.0.3",
    "jest-sonar-reporter": "^2.0.0",
    "msal-react-tester": "^0.3.1",
    "next-router-mock": "^0.9.13",
    "postcss": "^8.4.47",
    "postcss-preset-mantine": "^1.17.0",
    "postcss-simple-vars": "^7.0.1",
    "react-select-event": "^5.5.1",
    "sonar-scanner": "3.1.0",
    "typescript": "^5"
  }
}
EOF





# Crear estructura de carpetas
mkdir -p src/pages src/components  public

# Archivo index básico
cat <<EOF > src/pages/index.tsx
export default function Home() {
  return <div>Microfront: $APP_NAME</div>;
}
EOF
cat <<EOF > src/pages/_app.tsx
import type { AppProps } from "next/app";
export default function App({ Component, pageProps }: AppProps) {
 return <Component {...pageProps} />;
}
EOF
# Crear o modificar el archivo sonar-project.properties en la carpeta templates
cat <<EOF >sonar-project.properties
sonar.projectKey=$APP_NAME
sonar.projectName=$APP_NAME
sonar.projectVersion=0.1
sonar.sourceEncoding=UTF-8
sonar.projectDescription=Escaneo de análisis de código estático y porcentaje de cobertura de pruebas unitarias
sonar.sources=./src
sonar.exclusions=node_modules/**, bower_components/**, jspm_packages/**, typings/**, lib-cov/**, coverage/**, **/*_app.js, **/*_document.js, **/*middleware.js, jest.config.js, next.config.js, jest.setup.js, **/public/**, config/**, **/services/index.js, msal.js, **/pages/**, **/helpers/**, src/app/styles/**, **/mocks/**, src/mocks/**, **/src/mocks/**, Dockerfile, **/*.module.scss, **/*.yaml, **/*.scss, **/*.xml, **/*.common.ts
sonar.test.inclusions=**/__test__/**/*.test.tsx, **/*.test.tsx, **/*.test.js, **/*.test.ts
sonar.testExecutionReportPaths=test-report.xml
sonar.javascript.lcov.reportPaths=coverage/lcov.info
EOF

cat <<EOF >next.config.js
const path = require("path");
const NextFederationPlugin = require("@module-federation/nextjs-mf");

/** @type {import('next').NextConfig} */
const nextConfig = {
  output: "standalone",
  reactStrictMode: true,
  assetPrefix: process.env.NEXT_PUBLIC_ASSET_PREFIX,
  basePath: process.env.NEXT_PUBLIC_BASE_PATH,
  sassOptions: {
    includePaths: [path.join(__dirname, "styles")],
  },
  images: {
    loader: "custom",
    path: process.env.NEXT_PUBLIC_BASE_PATH,
    dangerouslyAllowSVG: true,
    contentDispositionType: "attachment",
    contentSecurityPolicy: "default-src 'self'; script-src 'none'; sandbox;",
    domains: [], 
  },
  publicRuntimeConfig: {},
  webpack(config, options) {
    const { isServer } = options;
    if (!isServer) {
      config.resolve.fallback.fs = false;
    }
    config.plugins.push(
      new NextFederationPlugin({
        name: "$APP_NAME", 
        remotes: {},
        filename: "static/chunks/remoteEntry.js",
        exposes: {
          "./Component": "./src/pages/index.tsx",
        },
        extraOptions: {
          exposePages: true,
          enableImageLoaderFix: true,
          enableUrlLoaderFix: true,
        },
      })
    );
    return config;
  },
};

module.exports = nextConfig;


EOF

cat <<EOF > .env.development.local
NEXT_PRIVATE_LOCAL_WEBPACK=true
NEXT_PUBLIC_URL_BACKEND_PENDIGITAL=http://localhost:$PORT/

EOF

shopt -s dotglob

cp "$SCRIPT_DIR/templates/"* .
# cp ../templates/tsconfig.json .
# cp ../templates/.env .
# cp ../templates/README.md .

shopt -u dotglob


# npx npm-add-script -k "dev" -v "cross-env NEXT_PRIVATE_LOCAL_WEBPACK=true next dev -p $PORT "
# npx npm-add-script -k "build" -v "next build"
# npx npm-add-script -k "start" -v "next start"
# npx npm-add-script -k "lint" -v "next lint"
# npx npm-add-script -k "test" -v "jest"
# Instalar todas las dependencias
npm install 
echo "Microfront $APP_NAME creado con éxito."

echo "Para iniciar, entra en la carpeta y ejecuta: npm run dev"
