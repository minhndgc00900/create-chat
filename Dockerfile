#specify note version and image
FROM node:14 AS development

WORKDIR /app

# Copy package-lock.json & package.json from host to inside container working directory
COPY package*.json ./

# Install deps inside container
RUN npm install

RUN npm run build

EXPOSE 3000

################
## PRODUCTION ##
################
# Build another image named production
FROM node:14 AS production

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

# Set work dir
WORKDIR /app

COPY --from=development /app/ .

EXPOSE 3000

# run app
CMD [ "node", "dist/main"]