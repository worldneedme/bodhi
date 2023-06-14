function handle_stop
    rm -f userlist server.json knck stop
    echo
    logger 2 "@bodhi.handle_stop -> Stopped"
    exit 0
end