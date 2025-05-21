FROM azeupvprddvoacr01.azurecr.io/node:23-alpine AS BUILD_IMAGE

# RUN apk add --no-cache libc6-compat
WORKDIR /app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY package.json package-lock.json* ./
COPY .npmrc .npmrc

# RUN npm install -f --verbose
RUN npm install --save --legacy-peer-deps

# FROM base AS builder
# WORKDIR /app

COPY . .

ARG ENV_NODE
ENV ENV_NODE=$ENV_NODE
RUN echo "El valor de mi ENV_NODE: $ENV_NODE"
COPY ${ENV_NODE} .env.production

# ENV NEXT_TELEMETRY_DISABLED 1

# RUN npm ls

RUN npm run build

FROM azeupvprddvoacr01.azurecr.io/node:23-alpine

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

USER appuser

# ENV NEXT_TELEMETRY_DISABLED 1

# RUN addgroup --system --gid 1001 nodejs
# RUN adduser --system --uid 1001 nextjs

COPY --from=BUILD_IMAGE /app/node_modules ./node_modules
COPY --from=BUILD_IMAGE /app/public ./public
COPY --from=BUILD_IMAGE --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=BUILD_IMAGE --chown=nextjs:nodejs /app/.next/static ./.next/static

ARG PORT
ENV PORT=$PORT
EXPOSE ${PORT}

CMD ["node", "server.js"]