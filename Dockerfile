FROM node:alpine as builder

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

RUN npm run build


FROM nginx
# This does nothing automatically locally. More as a documentation. However, services like elasticbeanstalk 
# uses this EXPORT <port> information to map directly to
# otherwise, things wont work when we deploy our app because 
# we always need to give docker info about port mapping i.e something like
# docker run -p <port from outside>:<port in our container> (e.g docker run -p elasticBS-PORT:80)
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
