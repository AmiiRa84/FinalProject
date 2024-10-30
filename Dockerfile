
FROM node:20 AS builder

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci

COPY . .

RUN npm run build

FROM node:20 AS runner

WORKDIR /app

COPY --from=builder /app/build ./build  # Change this to where your build output is located


COPY package.json package-lock.json ./
RUN npm ci --only=production  # Use --only=production to avoid installing dev dependencies

# application port
EXPOSE 3000 


CMD ["node", "build/index.js"]
