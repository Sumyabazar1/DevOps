FROM node:12-alpine AS builder
WORKDIR /usr/src/app
COPY ./package* ./
RUN npm install
COPY . .
RUN npm run build
FROM node:12-alpine 
WORKDIR /usr/src/app

COPY  --from=builder /usr/src/app/.next ./.next
COPY  --from=builder /usr/src/app/node_modules ./node_modules
COPY  --from=builder /usr/src/app/package.json ./package.json
COPY  --from=builder /usr/src/app/public ./public
EXPOSE 3000
CMD ["yarn", "start"]