FROM node:21-alpine as builder

WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build


FROM node:21-alpine

WORKDIR /usr/src/app
COPY --from=builder /usr/src/app/dist /usr/src/app
COPY --from=builder /usr/src/app/node_modules /usr/src/app/node_modules
CMD [ "node", "main.js" ]