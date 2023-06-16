# bodhi
Open source hysteria backend for v2board

Install with **Docker compose** at https://github.com/lotusproxy/bodhi-docker

# How to use?

SuperProTip: Only mode A is supported in bodhi-docker

```
A. Bedrock mode: run with config file
 1. Do "./product -i -v debug" to generate config files and download dependence
 2. modify ./config.ini
    upstream_api=https://example.com <- board address
    api_port=7653 <- Hysteria api port
    nodeid=1 <- remote nodeID
    core_path=/path/to/core <- path to hysteria executable
    tls_cert=/path/to/cert <-path to tls cert
    tls_key=/path/to/key <- path to tls key
    psk=leuleuleuleu <- password for nodeAPI
    obfs=true/false <- enable/disable obfs in hysteria
 3. After you finish that, ./product to launch
 4. CTRL+c or SIGINT to stop bodhi safely

B. OTF(On The Fly) mode: run with args
    -v/--verbose= [debug/info]
    -d/--root= [Root for running]
    -p/--port= [Hysteria api port]
    -u/--upstream= [Board address]
    -n/--nodeid= [Remote nodeID]
    -o/--tls_cert= [Path to cert]
    -k/--tls_key= [Path to key]
    -q/--core_path= [Path to core]
    -r/--psk= [Password for nodeAPI]
    -f/--on_the_fly [Must Have when using OTF mode]
    -b/--obfs= [enable/disable obfs in hysteria]
```
ProTip: Ctrl+C to stop

# It's usable now

Todo:

- ~~User Reports~~
- ~~Docker~~
- ~~Dynamic update~~