FROM golang:1.10 as build

RUN go get github.com/gohugoio/hugo
WORKDIR /site
COPY ./config.toml config.toml 
COPY archetypes archetypes
COPY data data
COPY layouts layouts
COPY content content
COPY themes themes
COPY content content
COPY static static

RUN hugo 

FROM nginx
VOLUME /usr/share/nginx/html/pipelines
COPY --from=build /site/public /usr/share/nginx/html/pipelines
COPY mysite-nginx.conf /etc/nginx/conf.d/default.conf
