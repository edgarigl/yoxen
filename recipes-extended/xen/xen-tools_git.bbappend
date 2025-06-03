XEN_REL = "4.21"

#FILES:${PN}-misc:append = " ${libdir}/xen/bin/xen-9pfsd"
FILES:${PN}-misc:append = " ${libdir}/libxenmanage.so.1.0"
FILES:${PN}-misc:append = " ${libdir}/libxenmanage.so.1"
FILES:${PN}-dev:append = " ${libdir}/libxenmanage.so"
FILES:${PN}-dev:append = " ${libdir}/pkgconfig/xenmanage.pc"
FILES:${PN}-misc:append = " ${libdir}/xen/bin/test-xenstore"
FILES:${PN}-misc:append = " ${libdir}/xen/bin/test-paging-mempool"
FILES:${PN}-misc:append = " ${libdir}/xen/bin/test-resource"
FILES:${PN}-misc:append = " ${libdir}/xen/bin/test-rangeset"

INSANE_SKIP:${PN} = "installed-vs-shipped"

DEFAULT_PREFERENCE ??= "1"
