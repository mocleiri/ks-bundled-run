# Kuali Student Bundled Runner

This is a simple script that can be run on a host running docker to provision an oracle container and run the final kuali student build, build-917.

This runs the ks-with-rice-bundled web application with rice and KS deployed in the same war file.

```
$ chmod +x run-ks-build-917.sh
$ ./run-ks-build-917.sh

(wait 5-10 minutes for impex to insert the base data)
```
The script will start the wnameless/oracle-xe-11g image and then use the kualistudent/bundled-impex image to load the reference data for build-917.

Once the impex process is completed it will start up the application.

You need to wait for the application to finish starting (when you see that its running on port 8080).  Use the **docker logs** command.

``` 
$ docker logs -f ks-with-rice-bundled
```

# Accessing KS Web Interface 

Once ks-with-rice-bundled has finished starting up you will want to know its IP address.  This can be determined by running the **docker inspect** command.

```
$ docker inspect ks-with-rice-bundled | grep IP
        "IPAddress": "172.17.0.27",
        "IPPrefixLen": 16,
```

If you are running directly on a Linux box you can just connect to http://172.17.0.27:8080 directly.

If you are running Linux inside of a virtual machine you will need to add a static route to the 172.17.0.0/16 network through the network interface connecting your computer to the virtual machine.

## Add Static Virtual Machine Route on Windows

For example in Windows 7 that would be:

```
c:> route add 172.17.0.0 mask 255.255.0.0 a.b.c.d metric xyz
```

a.b.c.d is the network address of the Linux box (on its side of the host to VM network)

xyz is the number that corresponds to the virtual network interface through which the a.b.c.d host is available through.

```
c:> route print 
```
this will show a 'metric' column which will contain the xyz number needed above.

