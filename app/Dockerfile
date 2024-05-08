FROM fnproject/node:18-dev as build-stage
WORKDIR /function
ADD package.json /function/
RUN npm install  && chown -R $(id -u):$(id -g) node_modules
FROM fnproject/node:18
WORKDIR /function
ADD . /function/
COPY --from=build-stage /function/node_modules/ /function/node_modules/
RUN chmod -R o+r /function
ENTRYPOINT ["node", "func.js"]
