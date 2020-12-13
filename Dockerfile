FROM node:14.15.1-alpine3.10 as build

WORKDIR /app

COPY *.json ./
RUN npm ci

COPY ./src ./src
RUN npm run prebuild && npm run build

FROM node:14.15.1-alpine3.10

WORKDIR /app

COPY package*.json ./
RUN npm ci --production

COPY --from=build /app/dist ./dist

EXPOSE 4000
CMD [ "npm", "run", "start:prod" ]