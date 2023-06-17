function init
    if test -r . -a -w .
    else
        logger 5 "@bodhi.init HALT -> bodhi.root is not readable or writable"
        exit 1
    end
    # def var
    set shop_list
    # check deps
    if test -e ./bin
        if test -d ./bin
            if test -e ./bin/yq
                if test -x ./bin/yq
                    switch (uname -m)
                        case x86_64
                            if file ./bin/yq | string match -rq x86-64
                            else
                                logger 4 "@bodhi.init WARN -> lib.yq wrong arch, fetching from gitub"
                                rm ./bin/yq
                                init
                            end
                        case aarch64
                            if file ./bin/yq | string match -rq aarch64
                            else
                                logger 4 "@bodhi.init WARN -> lib.yq wrong arch, fetching from gitub"
                                rm ./bin/yq
                                init
                            end
                    end
                    alias yq "$loc/bin/yq"
                else
                    chmod +x ./bin/yq
                    alias yq "$loc/bin/yq"
                end
            else
                logger 4 "@bodhi.init WARN -> lib.yq not found, fetching from gitub"
                switch (uname -m)
                    case x86_64
                        if curl -L --progress-bar (curl -sL https://api.github.com/repos/mikefarah/yq/releases/latest | string match -e "browser" | string match -r 'https://[^"]+' | string match -e "yq_linux_amd64" | string match -vr '\.tar\.gz') -o ./bin/yq
                            chmod +x ./bin/yq
                            alias yq "$loc/bin/yq"
                        else
                            logger 5 "@bodhi.init HALT -> Unable to fetch yq from github"
                            exit 1
                        end
                    case aarch64
                        if curl -L --progress-bar (curl -sL https://api.github.com/repos/mikefarah/yq/releases/latest | string match -e "browser" | string match -r 'https://[^"]+' | string match -e "yq_linux_arm64" | string match -vr '\.tar\.gz') -o ./bin/yq
                            chmod +x ./bin/yq
                            alias yq "$loc/bin/yq"
                        else
                            logger 5 "@bodhi.init HALT -> Unable to fetch yq from github"
                            exit 1
                        end
                end
            end
        else
            logger 5 "@bodhi.init HALT -> ./bin Not a directory, please remove it"
            exit 1
        end
    else
        mkdir bin
        init
    end
    # creating config
    if set -q _flag_on_the_fly
    else
        if test -e "$bodhi_conf"
        else
            echo 'upstream_api=https://example.com
api_port=7653
nodeid=1
core_path=/path/to/core
tls_cert=/path/to/cert
tls_key=/path/to/key
psk=leuleuleuleu
obfs=true' >"$bodhi_conf"
            logger 0 "@bodhi.init CONT -> Please modify the config file and relaunch bodhi again"
            exit 0
        end
    end
    # Check TLSnec
    # Check core
    if test -e $tls_cert; and test -e $tls_key
    else
        logger 5 "@bodhi.init HALT -> TLS cert or TLS key is not found at bodhi.tls_x"
        exit 1
    end
    if test -e "$core_path"
        if test -x "$core_path"
        else
            chmod +x "$core_path"
        end
    else
        logger 5 "@bodhi.init HALT -> Hysteria core is not found at bodhi.core_path"
        exit 1
    end
end
