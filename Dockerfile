FROM node:20-bullseye-slim AS base

WORKDIR /usr/src/app

COPY package* .json ./

FROM base AS dev 

RUN npm install

COPY . .

CMD ["node", "src/server.js"]

FROM base AS production

ENV NODE_ENV production

RUN npm ci --only=production

USER node

COPY --chown=node:node ./src/ .

EXPOSE 3000


CMD ["node", "/src/server.js"]