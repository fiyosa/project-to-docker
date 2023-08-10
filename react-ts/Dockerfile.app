FROM node:14.21.3-slim

WORKDIR /usr/share/nginx/html

COPY package.json ./

RUN npm install --silent

COPY ./ ./

RUN npm run build