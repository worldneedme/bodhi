function handle_stop
    rm -f userlist server.json knck stop
    logger 1 "
@bodhi.handle_stop -> Stopped"
    exit 0
end