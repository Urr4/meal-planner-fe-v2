FROM node:alpine3.15 as build
WORKDIR angular-app
COPY package.json package-lock.json ./
RUN echo "Running inital install for dependency cache"
RUN npm install
COPY . .
RUN echo "Running build"
RUN npm run build

FROM nginx:1.21.5
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build angular-app/dist/meal-planner-fe /usr/share/nginx/html
RUN echo "Done!"
