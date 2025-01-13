server {
    listen 80;
    server_name ${domain};
    
    %{ for location in locations }
    location ${location.path} {
        proxy_pass ${location.proxy_pass};
    }
    %{ endfor }
}