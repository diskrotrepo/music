# diskrot network

## Ubuntu Setup

1. Copy the diskrot.service to /etc/systemd/system/

2. Enable and start the service
```bash
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable diskrot.service
sudo systemctl start diskrot.service
```