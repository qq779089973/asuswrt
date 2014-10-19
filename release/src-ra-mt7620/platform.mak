export LINUXDIR := $(SRCBASE)/linux/linux-2.6.36.x

EXTRA_CFLAGS := -DLINUX26 -DCONFIG_RALINK -pipe -DDEBUG_NOISY -DDEBUG_RCTEST

export CONFIG_LINUX26=y
export CONFIG_RALINK=y

EXTRA_CFLAGS += -DLINUX30
export CONFIG_LINUX30=y

define platformRouterOptions
	@( \
	if [ "$(RALINK)" = "y" ]; then \
		sed -i "/RTCONFIG_RALINK\>/d" $(1); \
		echo "RTCONFIG_RALINK=y" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_IPV6/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_IPV6 is not set" >>$(1); \
		if [ "$(RT3883)" = "y" ]; then \
			sed -i "/RTCONFIG_RALINK_RT3883/d" $(1); \
			echo "RTCONFIG_RALINK_RT3883=y" >>$(1); \
		else \
			sed -i "/RTCONFIG_RALINK_RT3883/d" $(1); \
			echo "# RTCONFIG_RALINK_RT3883 is not set" >>$(1); \
		fi; \
		if [ "$(RT3052)" = "y" ]; then \
			sed -i "/RTCONFIG_RALINK_RT3052/d" $(1); \
			echo "RTCONFIG_RALINK_RT3052=y" >>$(1); \
		else \
			sed -i "/RTCONFIG_RALINK_RT3052/d" $(1); \
			echo "# RTCONFIG_RALINK_RT3052 is not set" >>$(1); \
		fi; \
		if [ "$(MT7620)" = "y" ]; then \
			sed -i "/RTCONFIG_RALINK_MT7620/d" $(1); \
			echo "RTCONFIG_RALINK_MT7620=y" >>$(1); \
		else \
			sed -i "/RTCONFIG_RALINK_MT7620/d" $(1); \
			echo "# RTCONFIG_RALINK_MT7620 is not set" >>$(1); \
		fi; \
	fi; \
	)
endef

define platformBusyboxOptions
endef

BOOT_FLASH_TYPE_POOL =	\
	"NOR"		\
	"SPI"		\
	"NAND"

DRAM_POOL = 		\
	"8M"		\
	"16M"		\
	"32M"		\
	"64M"		\
	"128M"		\
	"256M"

SECOND_IF_POOL = 	\
	"NONE"		\
	"RT3092"	\
	"RT5392"	\
	"RT5592"	\
	"RT3593"	\
	"MT7610"	\
	"RT3572"	\
	"RT5572"

define platformKernelConfig
	@( \
	if [ "$(RALINK)" = "y" ]; then \
		if [ "$(RT3052)" = "y" ]; then \
			sed -i "/CONFIG_RALINK_RT3052_MP2/d" $(1); \
			echo "CONFIG_RALINK_RT3052_MP2=y" >>$(1); \
			sed -i "/CONFIG_RALINK_RT3052/d" $(1); \
			echo "CONFIG_RALINK_RT3052=y" >>$(1); \
			sed -i "/CONFIG_MTD_PHYSMAP_START/d" $(1); \
			echo "CONFIG_MTD_PHYSMAP_START=0xBF000000" >>$(1); \
			sed -i "/CONFIG_RT3052_ASIC/d" $(1); \
			echo "CONFIG_RT3052_ASIC=y" >>$(1); \
			sed -i "/CONFIG_RT2880_DRAM_128M/d" $(1); \
			sed -i "/CONFIG_RT2880_DRAM_32M/d" $(1); \
			echo "CONFIG_RT2880_DRAM_32M=y" >>$(1); \
			sed -i "/CONFIG_RALINK_RAM_SIZE/d" $(1); \
			echo "CONFIG_RALINK_RAM_SIZE=32" >>$(1); \
			sed -i "/CONFIG_RALINK_RT3883_MP/d" $(1); \
			echo "# CONFIG_RALINK_RT3883_MP is not set" >>$(1); \
			sed -i "/CONFIG_RALINK_RT3883/d" $(1); \
			echo "# CONFIG_RALINK_RT3883 is not set" >>$(1); \
			sed -i "/CONFIG_RT3883_ASIC/d" $(1); \
			echo "# CONFIG_RT3883_ASIC is not set" >>$(1); \
			sed -i "/CONFIG_RALINK_RT3883_MP/d" $(1); \
			echo "# CONFIG_RALINK_RT3883_MP is not set" >>$(1); \
			sed -i "/CONFIG_RALINK_RT3883_MP/d" $(1); \
			echo "# CONFIG_RALINK_RT3883_MP is not set" >>$(1); \
			sed -i "/CONFIG_RALINK_RT3662_2T2R/d" $(1); \
			echo "# CONFIG_RALINK_RT3662_2T2R is not set" >>$(1); \
			sed -i "/CONFIG_RALINK_RT3052_2T2R/d" $(1); \
			echo "CONFIG_RALINK_RT3052_2T2R=y" >>$(1); \
			sed -i "/CONFIG_RALINK_RT3352/d" $(1); \
			echo "# CONFIG_RALINK_RT3352 is not set" >>$(1); \
			sed -i "/CONFIG_LAN_WAN_SUPPORT/d" $(1); \
			echo "CONFIG_LAN_WAN_SUPPORT=y" >>$(1); \
			sed -i "/CONFIG_RT_3052_ESW/d" $(1); \
			echo "CONFIG_RT_3052_ESW=y" >>$(1); \
		fi; \
		if [ "$(RTAC51U)" = "y" ] && [ $(BOOT_FLASH_TYPE) = "SPI" ] ; then \
			sed -i "/CONFIG_MTD_SPI_FAST_CLOCK/d" $(1); \
			echo "CONFIG_MTD_SPI_FAST_CLOCK=y" >>$(1); \
		fi; \
	fi; \
	for bftype in $(BOOT_FLASH_TYPE_POOL) ; do \
		sed -i "/CONFIG_MTD_$${bftype}_RALINK\>/d" $(1); \
		if [ "$(BOOT_FLASH_TYPE)" = "$${bftype}" ] ; then \
			echo "CONFIG_MTD_$${bftype}_RALINK=y" >> $(1); \
		else \
			echo "# CONFIG_MTD_$${bftype}_RALINK is not set" >> $(1); \
		fi; \
	done; \
	sed -i "/CONFIG_MTD_ANY_RALINK/d" $(1); \
	echo "# CONFIG_MTD_ANY_RALINK is not set" >>$(1); \
	for dram in $(DRAM_POOL) ; do \
		sed -i "/CONFIG_RT2880_DRAM_$${dram}\>/d" $(1); \
		if [ "$(DRAM)" = "$${dram}" ] ; then \
			echo "CONFIG_RT2880_DRAM_$${dram}=y" >> $(1); \
		else \
			echo "# CONFIG_RT2880_DRAM_$${dram} is not set" >> $(1); \
		fi; \
	done; \
	for sec_if in $(SECOND_IF_POOL) ; do \
		sed -i "/CONFIG_MTD_$${sec_if}_RALINK\>/d" $(1); \
		if [ "$(SECOND_IF)" = "$${sec_if}" ] ; then \
			echo "CONFIG_SECOND_IF_$${sec_if}=y" >> $(1); \
		else \
			echo "# CONFIG_SECOND_IF_$${sec_if} is not set" >> $(1); \
		fi; \
	done; \
	if [ "$(SECOND_IF)" = "MT7610" ] ; then \
		sed -i "/CONFIG_MT7610_AP\>/d" $(1); \
		echo "CONFIG_MT7610_AP=m" >>$(1); \
		sed -i "/CONFIG_MT7610_AP_V24_DATA_STRUCTURE/d" $(1); \
		echo "CONFIG_MT7610_AP_V24_DATA_STRUCTURE=y" >>$(1); \
		sed -i "/CONFIG_MT7610_AP_LED/d" $(1); \
		echo "CONFIG_MT7610_AP_LED=y" >>$(1); \
		sed -i "/CONFIG_MT7610_AP_WSC/d" $(1); \
		echo "CONFIG_MT7610_AP_WSC=y" >>$(1); \
		sed -i "/CONFIG_MT7610_AP_WSC_V2/d" $(1); \
		echo "CONFIG_MT7610_AP_WSC_V2=y" >>$(1); \
		sed -i "/CONFIG_MT7610_AP_LLTD/d" $(1); \
		echo "CONFIG_MT7610_AP_LLTD=y" >>$(1); \
		sed -i "/CONFIG_MT7610_AP_WDS/d" $(1); \
		echo "CONFIG_MT7610_AP_WDS=y" >>$(1); \
		sed -i "/CONFIG_MT7610_AP_MBSS/d" $(1); \
		echo "CONFIG_MT7610_AP_MBSS=y" >>$(1); \
		sed -i "/CONFIG_MT7610_AP_APCLI/d" $(1); \
		echo "# CONFIG_MT7610_AP_APCLI is not set" >>$(1); \
		sed -i "/CONFIG_MT7610_AP_IGMP_SNOOP/d" $(1); \
		echo "CONFIG_MT7610_AP_IGMP_SNOOP=y" >>$(1); \
		sed -i "/CONFIG_MT7610_AP_DFS/d" $(1); \
		echo "# CONFIG_MT7610_AP_DFS is not set" >>$(1); \
		sed -i "/CONFIG_MT7610_AP_CARRIER/d" $(1); \
		echo "# CONFIG_MT7610_AP_CARRIER is not set" >>$(1); \
		sed -i "/CONFIG_MT7610_AP_80211N_DRAFT3/d" $(1); \
		echo "CONFIG_MT7610_AP_80211N_DRAFT3=y" >>$(1); \
		sed -i "/CONFIG_MT7610_AP_ATE/d" $(1); \
		echo "CONFIG_MT7610_AP_ATE=y" >>$(1); \
		sed -i "/CONFIG_MT7610_AP_QA/d" $(1); \
		echo "CONFIG_MT7610_AP_QA=y" >>$(1); \
		sed -i "/CONFIG_MT7610_AP_FLASH/d" $(1); \
		echo "CONFIG_MT7610_AP_FLASH=y" >>$(1); \
		sed -i "/CONFIG_MT7610_AP_BIG_ENDIAN/d" $(1); \
		echo "# CONFIG_MT7610_AP_BIG_ENDIAN is not set" >>$(1); \
		sed -i "/CONFIG_MT7610_AP_TSSI_COMPENSATION/d" $(1); \
		echo "# CONFIG_MT7610_AP_TSSI_COMPENSATION is not set" >>$(1); \
		sed -i "/CONFIG_RTMP_TEMPERATURE_COMPENSATION/d" $(1); \
		echo "CONFIG_RTMP_TEMPERATURE_COMPENSATION=y" >>$(1); \
		sed -i "/CONFIG_MT7610_AP_SINGLE_SKU/d" $(1); \
		echo "# CONFIG_MT7610_AP_SINGLE_SKU is not set" >>$(1); \
		sed -i "/CONFIG_MT7610_MCAST_RATE_SPECIFIC/d" $(1); \
		echo "CONFIG_MT7610_MCAST_RATE_SPECIFIC=y" >>$(1); \
	fi; \
	if [ "$(REPEATER)" = "y" ] ; then \
			sed -i "/CONFIG_RT2860V2_AP_APCLI/d" $(1); \
			echo "CONFIG_RT2860V2_AP_APCLI=y" >>$(1); \
			sed -i "/CONFIG_RT2860V2_AP_MAC_REPEATER/d" $(1); \
			echo "CONFIG_RT2860V2_AP_MAC_REPEATER=y" >>$(1); \
		if [ "$(SECOND_IF)" = "MT7610" ] ; then \
			sed -i "/CONFIG_MT7610_AP_APCLI/d" $(1); \
			echo "CONFIG_MT7610_AP_APCLI=y" >>$(1); \
			sed -i "/CONFIG_MT7610_AP_MAC_REPEATER/d" $(1); \
			echo "CONFIG_MT7610_AP_MAC_REPEATER=y" >>$(1); \
			sed -i "CONFIG_M7610_CON_WPS_SUPPORT/d" $(1); \
			echo "# CONFIG_M7610_CON_WPS_SUPPORT is not set" >>$(1); \
		fi; \
	fi; \
	if [ "$(RA_SKU)" = "y" ] ; then \
			sed -i "/CONFIG_RT2860V2_SINGLE_SKU/d" $(1); \
			echo "CONFIG_RT2860V2_SINGLE_SKU=y" >>$(1); \
		if [ "$(SECOND_IF)" = "MT7610" ] ; then \
			sed -i "/CONFIG_MT7610_AP_SINGLE_SKU/d" $(1); \
			echo "CONFIG_MT7610_AP_SINGLE_SKU=y" >>$(1); \
		fi; \
	fi; \
	if [ "$(UBI)" = "y" ]; then \
		sed -i "/CONFIG_MTD_UBI\>/d" $(1); \
		echo "CONFIG_MTD_UBI=y" >>$(1); \
		sed -i "/CONFIG_MTD_UBI_WL_THRESHOLD/d" $(1); \
		echo "CONFIG_MTD_UBI_WL_THRESHOLD=4096" >>$(1); \
		sed -i "/CONFIG_MTD_UBI_BEB_RESERVE/d" $(1); \
		echo "CONFIG_MTD_UBI_BEB_RESERVE=1" >>$(1); \
		sed -i "/CONFIG_MTD_UBI_GLUEBI/d" $(1); \
		echo "CONFIG_MTD_UBI_GLUEBI=y" >>$(1); \
		sed -i "/CONFIG_FACTORY_CHECKSUM/d" $(1); \
		echo "CONFIG_FACTORY_CHECKSUM=y" >>$(1); \
		if [ "$(UBI_DEBUG)" = "y" ]; then \
			sed -i "/CONFIG_MTD_UBI_DEBUG/d" $(1); \
			echo "CONFIG_MTD_UBI_DEBUG=y" >>$(1); \
			sed -i "/CONFIG_GCOV_KERNEL/d" $(1); \
			echo "# CONFIG_GCOV_KERNEL is not set" >>$(1); \
			sed -i "/CONFIG_L2TP_DEBUGFS/d" $(1); \
			echo "# CONFIG_L2TP_DEBUGFS is not set" >>$(1); \
			sed -i "/CONFIG_MTD_UBI_DEBUG_MSG/d" $(1); \
			echo "CONFIG_MTD_UBI_DEBUG_MSG=y" >>$(1); \
			sed -i "/CONFIG_MTD_UBI_DEBUG_PARANOID/d" $(1); \
			echo "# CONFIG_MTD_UBI_DEBUG_PARANOID is not set" >>$(1); \
			sed -i "/CONFIG_MTD_UBI_DEBUG_DISABLE_BGT/d" $(1); \
			echo "# CONFIG_MTD_UBI_DEBUG_DISABLE_BGT is not set" >>$(1); \
			sed -i "/CONFIG_MTD_UBI_DEBUG_EMULATE_BITFLIPS/d" $(1); \
			echo "CONFIG_MTD_UBI_DEBUG_EMULATE_BITFLIPS=y" >>$(1); \
			sed -i "/CONFIG_MTD_UBI_DEBUG_EMULATE_WRITE_FAILURES/d" $(1); \
			echo "CONFIG_MTD_UBI_DEBUG_EMULATE_WRITE_FAILURES=y" >>$(1); \
			sed -i "/CONFIG_MTD_UBI_DEBUG_EMULATE_ERASE_FAILURES/d" $(1); \
			echo "CONFIG_MTD_UBI_DEBUG_EMULATE_ERASE_FAILURES=y" >>$(1); \
			sed -i "/CONFIG_MTD_UBI_DEBUG_MSG_BLD/d" $(1); \
			echo "CONFIG_MTD_UBI_DEBUG_MSG_BLD=y" >>$(1); \
			sed -i "/CONFIG_MTD_UBI_DEBUG_MSG_EBA/d" $(1); \
			echo "CONFIG_MTD_UBI_DEBUG_MSG_EBA=y" >>$(1); \
			sed -i "/CONFIG_MTD_UBI_DEBUG_MSG_WL/d" $(1); \
			echo "CONFIG_MTD_UBI_DEBUG_MSG_WL=y" >>$(1); \
			sed -i "/CONFIG_MTD_UBI_DEBUG_MSG_IO/d" $(1); \
			echo "CONFIG_MTD_UBI_DEBUG_MSG_IO=y" >>$(1); \
			sed -i "/CONFIG_JBD_DEBUG/d" $(1); \
			echo "# CONFIG_JBD_DEBUG is not set" >>$(1); \
			sed -i "/CONFIG_LKDTM/d" $(1); \
			echo "# CONFIG_LKDTM is not set" >>$(1); \
			sed -i "/CONFIG_DYNAMIC_DEBUG/d" $(1); \
			echo "CONFIG_DYNAMIC_DEBUG=y" >>$(1); \
			sed -i "/CONFIG_SPINLOCK_TEST/d" $(1); \
			echo "# CONFIG_SPINLOCK_TEST is not set" >>$(1); \
		else \
			sed -i "/CONFIG_MTD_UBI_DEBUG/d" $(1); \
			echo "# CONFIG_MTD_UBI_DEBUG is not set" >>$(1); \
		fi; \
		if [ "$(UBIFS)" = "y" ]; then \
			sed -i "/CONFIG_UBIFS_FS/d" $(1); \
			echo "CONFIG_UBIFS_FS=y" >>$(1); \
			sed -i "/CONFIG_UBIFS_FS_XATTR/d" $(1); \
			echo "# CONFIG_UBIFS_FS_XATTR is not set" >>$(1); \
			sed -i "/CONFIG_UBIFS_FS_ADVANCED_COMPR/d" $(1); \
			echo "CONFIG_UBIFS_FS_ADVANCED_COMPR=y" >>$(1); \
			sed -i "/CONFIG_UBIFS_FS_LZO/d" $(1); \
			echo "CONFIG_UBIFS_FS_LZO=y" >>$(1); \
			sed -i "/CONFIG_UBIFS_FS_ZLIB/d" $(1); \
			echo "CONFIG_UBIFS_FS_ZLIB=y" >>$(1); \
			sed -i "/CONFIG_UBIFS_FS_DEBUG/d" $(1); \
			echo "# CONFIG_UBIFS_FS_DEBUG is not set" >>$(1); \
		else \
			sed -i "/CONFIG_UBIFS_FS/d" $(1); \
			echo "# CONFIG_UBIFS_FS is not set" >>$(1); \
		fi; \
	fi; \
	if [ "$(DSL)" = "y" ]; then \
		sed -i "/CONFIG_RTL8367M/d" $(1); \
		echo "# CONFIG_RTL8367M is not set" >>$(1); \
		sed -i "/CONFIG_RTL8367R/d" $(1); \
		echo "CONFIG_RTL8367R=y" >>$(1); \
		sed -i "/CONFIG_RAETH_GMAC2/d" $(1); \
		echo "# CONFIG_RAETH_GMAC2 is not set" >>$(1); \
		sed -i "/CONFIG_GE2_RGMII_FORCE_1000/d" $(1); \
		echo "# CONFIG_GE2_RGMII_FORCE_1000 is not set" >>$(1); \
		sed -i "/CONFIG_RAETH_DSL/d" $(1); \
		echo "CONFIG_RAETH_DSL=y" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT/d" $(1); \
		echo "# CONFIG_RA_HW_NAT is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_AUTO_BIND/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_AUTO_BIND is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_MANUAL_BIND/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_MANUAL_BIND is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_SPEEDUP_UPSTREAM/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_SPEEDUP_UPSTREAM is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_SPEEDUP_DOWNSTREAM/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_SPEEDUP_DOWNSTREAM is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_SPEEDUP_BIDIRECTION/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_SPEEDUP_BIDIRECTION is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_LAN_VLANID/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_LAN_VLANID is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_WAN_VLANID/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_WAN_VLANID is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_BINDING_THRESHOLD/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_BINDING_THRESHOLD is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_QURT_LMT/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_QURT_LMT is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_HALF_LMT/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_HALF_LMT is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_FULL_LMT/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_FULL_LMT is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_TBL_1K/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_TBL_1K is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_TBL_2K/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_TBL_2K is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_TBL_4K/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_TBL_4K is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_TBL_8K/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_TBL_8K is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_TBL_16K/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_TBL_16K is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_HASH0/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_HASH0 is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_HASH1/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_HASH1 is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_PRE_ACL_SIZE/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_PRE_ACL_SIZE is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_PRE_MTR_SIZE/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_PRE_MTR_SIZE is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_PRE_AC_SIZE/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_PRE_AC_SIZE is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_POST_MTR_SIZE/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_POST_MTR_SIZE is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_POST_AC_SIZE/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_POST_AC_SIZE is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_TCP_KA/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_TCP_KA is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_UDP_KA/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_UDP_KA is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_ACL_DLTA/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_ACL_DLTA is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_UNB_DLTA/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_UNB_DLTA is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_UNB_MNP/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_UNB_MNP is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_UDP_DLTA/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_UDP_DLTA is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_TCP_DLTA/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_TCP_DLTA is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_FIN_DLTA/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_FIN_DLTA is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_IPV6/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_IPV6 is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_ACL2UP_HELPER/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_ACL2UP_HELPER is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_DSCP2UP_HELPER/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_DSCP2UP_HELPER is not set" >>$(1); \
		sed -i "/CONFIG_RA_HW_NAT_NONE2UP/d" $(1); \
		echo "# CONFIG_RA_HW_NAT_NONE2UP is not set" >>$(1); \
	fi; \
	)
endef
