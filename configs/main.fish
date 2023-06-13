#-> use: ["init", "chamber"]

set -x prefix [bodhi-free]
# def var
set -x bodhi_conf bodhi_root bodhi_verbose upstream_api api_port loc tls_cert nodeid tls_key psk

# parse argv
argparse -i -n $prefix 'i/init=' 'c/conf=' 'v/verbose=' 'd/root=' 'p/port=' 'u/upstream=' 'n/nodeid=' 'o/tls_cert=' 'k/tls_key=' 'q/core_path=' 'r/psk=' 'f/on_the_fly=' -- $argv

# load default settings
set bodhi_conf config.yml
set bodhi_root .
set bodhi_verbose info
set upstream_api 'https://example.com'
set api_port 7653
set nodeid 1
set core_path /path/to/core
set tls_key /path/to/key
set tls_cert /path/to/cert
set psk leuleuleuleu
set on_the_fly false

# load settings from argv
if set -q _flag_root
    set bodhi_root "$_flag_root"
end
if set -q _flag_verbose
    set bodhi_verbose "$_flag_verbose"
end
if set -q _flag_conf
    set bodhi_conf "$_flag_conf"
end
if set -q _flag_on_the_fly
    set on_the_fly "$_flag_on_the_fly"
end

# load settings from config
cd "$bodhi_root"
set loc (pwd)

if test "$_flag_init" != true
    set upstream_api (configure "upstream_api" "$bodhi_conf")
    set api_port (configure "api_port" "$bodhi_conf")
    set nodeid (configure "nodeid" "$bodhi_conf")
    set core_path (configure "core_path" "$bodhi_conf")
    set tls_cert (configure "tls_cert" "$bodhi_conf")
    set tls_key (configure "tls_key" "$bodhi_conf")
    set psk (configure "psk" "$bodhi_conf")
end
# load node settings from argv

if set -q _flag_upstream
    set upstream_api "$_flag_upstream"
end
if set -q _flag_nodeid
    set nodeid "$_flag_nodeid"
end
if set -q _flag_port
    set api_port "$_flag_port"
end
if set -q _flag_core_path
    set core_path "$_flag_core_path"
end
if set -q _flag_tls_cert
    set tls_cert "$_flag_tls_cert"
end
if set -q _flag_tls_key
    set tls_key "$_flag_tls_key"
end
if set -q _flag_psk
    set psk "$_flag_psk"
end

# print init vars
if test "$bodhi_verbose" = debug
    logger 3 "
bodhi_verbose => $bodhi_verbose
bodhi_root => $loc
bodhi_conf => $bodhi_conf
upstream_api => $upstream_api
api_port => $api_port
nodeid => $nodeid
core_path => $core_path
tls_key => $tls_key
tls_cert => $tls_cert
psk => $psk
on_the_fly => $on_the_fly
init => $_flag_init"
    logger 3 "SIG => Ready to go SIR!"
end

init

switch $argv[1]
    case h help
    case v version
    case '*'
        chamber
end
