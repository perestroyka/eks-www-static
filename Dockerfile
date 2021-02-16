FROM public.ecr.aws/nginx/nginx:latest
COPY ./www /usr/share/nginx/html
EXPOSE 8080
