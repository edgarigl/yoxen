# versal-virtio-msg-demo

This repo contains a kas setup to build a virtio-msg-demo-image for versal.

The image includes QEMU with patches adding virtio-msg support.
A UIO kernel module allowing user-space drivers to map memory ranges as
Non-Cached Normal Memory.
Scripts to monitor PCI FLRs, setup networking and run QEMU.

## Build images

First, you'll need to setup kas. See the [kas-setup](../README.md) for more information.
Once kas is setup, you need to run:
```console
$ kas build kas/yoxen-versal-virtio-msg-demo.yml
```

## Build SDK

If you'd like to compile custom applications for the target outside
of the Yocto environment, you can build an SDK that targets the rootfs
corresponding to the virtio-msg-demo-image:
```bash
$ kas shell kas/yoxen-versal-virtio-msg-demo.yml -c "bitbake -c populate_sdk versal-virtio-msg-demo-image"
```

## Running

Once the image boots, it will automatically run the pci-flr-monitor script.
Users need to run the ``run-versal-virtio-msg-net-backend.sh`` script to start QEMU:
```console
$ run-versal-virtio-msg-net-backend.sh 
+ qemu-system-aarch64 -M x-virtio-msg -m 2G -serial null -display none -daemonize -device virtio-msg-bus-vek280-hexcam,dev=/dev/uio0,spsc-base=0xa210000 -device virtio-net-device,mq=on,netdev=net0,iommu_platform=on -netdev tap,id=net0,ifname=tap0,script=no,downscript=no
[   34.286258] tun: Universal TUN/TAP device driver, 1.6
ftruncate: Invalid argument
host=0xfff726d0a000
Wait for queue
```

At this point, QEMU is waiting for the host to setup a virtio-msg/spsc-queue.
Once a queue is setup, the virtio-msg and virtio-net protocols proceed.

```console
cfg-bram: 1 a210000 0
Found queue at a210000
virtio_set_status: val 0
virtio_set_status: val 0
+ sleep 3
+ ifup xenbr0
device xenbr0 already exists; can't create bridge with the same name
[  282.475750] xenbr0: port 1(tap0) entered blocking state
[  282.480935] xenbr0: port 1(tap0) entered disabled state
[  282.486234] tap0: entered allmulticast mode
[  282.490570] tap0: entered promiscuous mode
udhcpc: started, v1.36.1
[  282.521811] xenbr0: port 1(tap0) entered blocking state
[  282.526970] xenbr0: port 1(tap0) entered forwarding state
udhcpc: broadcasting discover
udhcpc: broadcasting discover
udhcpc: broadcasting select for 10.0.6.143, server 10.0.6.1
udhcpc: lease of 10.0.6.143 obtained from 10.0.6.1, lease time 43200
/etc/udhcpc.d/50default: Adding DNS 10.0.6.1
```
