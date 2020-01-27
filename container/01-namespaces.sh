# Show proccesses namespaces
sudo ps ax -o pid,ppid,pidns,cmd --forest

# Show namespaces files
sudo ls -ltrh /proc/1/ns/