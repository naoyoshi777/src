#!/bin/sh

g_devmem=
g_devmem2=
g_devmem_cmd=

show_reg()
{
  local acronym=$1
  local base=$2
  local offset=$3
  local val=

  if [ "${g_devmem}" ]; then
    val=$(devmem $((base + offset)))
  elif [ "${g_devmem2}" ]; then
    val=$(devmem2 $((base + offset)) | awk '/Read/ {print $NF}')
  fi

  echo "${acronym} ${val}"
}


read_reg()
{
  local base=$1
  local offset=$2
  local val=

  val=$("${g_devmem_cmd}" $((base + offset))) || return 1

  if [ "${g_devmem_cmd}" = 'devmem' ]; then
    echo "${val}"
  else
    echo "${val}" | awk '/Read/ {print $NF}'
  fi

  return 0
}

show_cm_per()
{
  local base=0x44E00000

  show_reg 'CM_PER_L4LS_CLKSTCTRL' ${base} 0x0
  show_reg 'CM_PER_L3S_CLKSTCTRL' ${base} 0x4
  show_reg 'CM_PER_L3_CLKSTCTRL' ${base} 0xC
  show_reg 'CM_PER_CPGMAC0_CLKCTRL' ${base} 0x14
  show_reg 'CM_PER_LCDC_CLKCTRL' ${base} 0x18
  show_reg 'CM_PER_USB0_CLKCTRL' ${base} 0x1C
  show_reg 'CM_PER_TPTC0_CLKCTRL' ${base} 0x24
  show_reg 'CM_PER_EMIF_CLKCTRL' ${base} 0x28
  show_reg 'CM_PER_OCMCRAM_CLKCTRL' ${base} 0x2C
  show_reg 'CM_PER_GPMC_CLKCTRL' ${base} 0x30
  show_reg 'CM_PER_MCASP0_CLKCTRL' ${base} 0x34
  show_reg 'CM_PER_UART5_CLKCTRL' ${base} 0x38
  show_reg 'CM_PER_MMC0_CLKCTRL' ${base} 0x3C
  show_reg 'CM_PER_ELM_CLKCTRL' ${base} 0x40
  show_reg 'CM_PER_I2C2_CLKCTRL' ${base} 0x44
  show_reg 'CM_PER_I2C1_CLKCTRL' ${base} 0x48
  show_reg 'CM_PER_SPI0_CLKCTRL' ${base} 0x4C
  show_reg 'CM_PER_SPI1_CLKCTRL' ${base} 0x50
  show_reg 'CM_PER_L4LS_CLKCTRL' ${base} 0x60
  show_reg 'CM_PER_MCASP1_CLKCTRL' ${base} 0x68
  show_reg 'CM_PER_UART1_CLKCTRL' ${base} 0x6C
  show_reg 'CM_PER_UART2_CLKCTRL' ${base} 0x70
  show_reg 'CM_PER_UART3_CLKCTRL' ${base} 0x74
  show_reg 'CM_PER_UART4_CLKCTRL' ${base} 0x78
  show_reg 'CM_PER_TIMER7_CLKCTRL' ${base} 0x7C
  show_reg 'CM_PER_TIMER2_CLKCTRL' ${base} 0x80
  show_reg 'CM_PER_TIMER3_CLKCTRL' ${base} 0x84
  show_reg 'CM_PER_TIMER4_CLKCTRL' ${base} 0x88
  show_reg 'CM_PER_GPIO1_CLKCTRL' ${base} 0xAC
  show_reg 'CM_PER_GPIO2_CLKCTRL' ${base} 0xB0
  show_reg 'CM_PER_GPIO3_CLKCTRL' ${base} 0xB4
  show_reg 'CM_PER_TPCC_CLKCTRL' ${base} 0xBC
  show_reg 'CM_PER_DCAN0_CLKCTRL' ${base} 0xC0
  show_reg 'CM_PER_DCAN1_CLKCTRL' ${base} 0xC4
  show_reg 'CM_PER_EPWMSS1_CLKCTRL' ${base} 0xCC
  show_reg 'CM_PER_EPWMSS0_CLKCTRL' ${base} 0xD4
  show_reg 'CM_PER_EPWMSS2_CLKCTRL' ${base} 0xD8
  show_reg 'CM_PER_L3_INSTR_CLKCTRL' ${base} 0xDC
  show_reg 'CM_PER_L3_CLKCTRL' ${base} 0xE0
  show_reg 'CM_PER_IEEE5000_CLKCTRL' ${base} 0xE4
  show_reg 'CM_PER_PRU_ICSS_CLKCTRL' ${base} 0xE8
  show_reg 'CM_PER_TIMER5_CLKCTRL' ${base} 0xEC
  show_reg 'CM_PER_TIMER6_CLKCTRL' ${base} 0xF0
  show_reg 'CM_PER_MMC1_CLKCTRL' ${base} 0xF4
  show_reg 'CM_PER_MMC2_CLKCTRL' ${base} 0xF8
  show_reg 'CM_PER_TPTC1_CLKCTRL' ${base} 0xFC
  show_reg 'CM_PER_TPTC2_CLKCTRL' ${base} 0x100
  show_reg 'CM_PER_SPINLOCK_CLKCTRL' ${base} 0x10C
  show_reg 'CM_PER_MAILBOX0_CLKCTRL' ${base} 0x110
  show_reg 'CM_PER_L4HS_CLKSTCTRL' ${base} 0x11C
  show_reg 'CM_PER_L4HS_CLKCTRL' ${base} 0x120
  show_reg 'CM_PER_OCPWP_L3_CLKSTCTRL' ${base} 0x12C
  show_reg 'CM_PER_OCPWP_CLKCTRL' ${base} 0x130
  show_reg 'CM_PER_PRU_ICSS_CLKSTCTRL' ${base} 0x140
  show_reg 'CM_PER_CPSW_CLKSTCTRL' ${base} 0x144
  show_reg 'CM_PER_LCDC_CLKSTCTRL' ${base} 0x148
  show_reg 'CM_PER_CLKDIV32K_CLKCTRL' ${base} 0x14C
  show_reg 'CM_PER_24MHZ_CLKSTCTRL' ${base} 0x150
}

show_cm_wkup()
{
  local base=0x44E00400

  show_reg 'CM_WKUP_CLKSTCTRL' ${base} 0x0
  show_reg 'CM_WKUP_CONTROL_CLKCTRL' ${base} 0x4
  show_reg 'CM_WKUP_GPIO0_CLKCTRL' ${base} 0x8
  show_reg 'CM_WKUP_L4WKUP_CLKCTRL' ${base} 0xC
  show_reg 'CM_WKUP_TIMER0_CLKCTRL' ${base} 0x10
  show_reg 'CM_WKUP_DEBUGSS_CLKCTRL' ${base} 0x14
  show_reg 'CM_L3_AON_CLKSTCTRL' ${base} 0x18
  show_reg 'CM_AUTOIDLE_DPLL_MPU' ${base} 0x1C
  show_reg 'CM_IDLEST_DPLL_MPU' ${base} 0x20
  show_reg 'CM_SSC_DELTAMSTEP_DPLL_MPU' ${base} 0x24
  show_reg 'CM_SSC_MODFREQDIV_DPLL_MPU' ${base} 0x28
  show_reg 'CM_CLKSEL_DPLL_MPU' ${base} 0x2C
  show_reg 'CM_AUTOIDLE_DPLL_DDR' ${base} 0x30
  show_reg 'CM_IDLEST_DPLL_DDR' ${base} 0x34
  show_reg 'CM_SSC_DELTASTEP_DPLL_DDR' ${base} 0x38
  show_reg 'CM_SSC_MODFREQDIV_DPLL_DDR' ${base} 0x3C
  show_reg 'CM_CLKSEL_DPLL_DDR' ${base} 0x40
  show_reg 'CM_AUTOIDLE_DPLL_DISP' ${base} 0x44
  show_reg 'CM_IDLEST_DPLL_DISP' ${base} 0x48
  show_reg 'CM_SSC_DELTASTEP_DPLL_DISP' ${base} 0x4C
  show_reg 'CM_SSC_MODFREQDIV_DPLL_DISP' ${base} 0x50
  show_reg 'CM_CLKSEL_DPLL_DISP' ${base} 0x54
  show_reg 'CM_AUTOIDLE_DPLL_CORE' ${base} 0x58
  show_reg 'CM_IDLEST_DPLL_CORE' ${base} 0x5C
  show_reg 'CM_SSC_DELTASTEP_DPLL_CORE' ${base} 0x60
  show_reg 'CM_SSC_MODFREQDIV_DPLL_CORE' ${base} 0x64
  show_reg 'CM_CLKSEL_DPLL_CORE' ${base} 0x68
  show_reg 'CM_AUTOIDLE_DPLL_PER' ${base} 0x6C
  show_reg 'CM_IDLEST_DPLL_PER' ${base} 0x70
  show_reg 'CM_SSC_DELTASTEP_DPLL_PER' ${base} 0x74
  show_reg 'CM_SSC_MODFREQDIV_DPLL_PER' ${base} 0x78
  show_reg 'CM_CLKDCOLDO_DPLL_PER' ${base} 0x7C
  show_reg 'CM_DIV_M4_DPLL_CORE' ${base} 0x80
  show_reg 'CM_DIV_M5_DPLL_CORE' ${base} 0x84
  show_reg 'CM_CLKMODE_DPLL_MPU' ${base} 0x88
  show_reg 'CM_CLKMODE_DPLL_PER' ${base} 0x8C
  show_reg 'CM_CLKMODE_DPLL_CORE' ${base} 0x90
  show_reg 'CM_CLKMODE_DPLL_DDR' ${base} 0x94
  show_reg 'CM_CLKMODE_DPLL_DISP' ${base} 0x98
  show_reg 'CM_CLKSEL_DPLL_PERIPH' ${base} 0x9C
  show_reg 'CM_DIV_M2_DPLL_DDR' ${base} 0xA0
  show_reg 'CM_DIV_M2_DPLL_DISP' ${base} 0xA4
  show_reg 'CM_DIV_M2_DPLL_MPU' ${base} 0xA8
  show_reg 'CM_DIV_M2_DPLL_PER' ${base} 0xAC
  show_reg 'CM_WKUP_WKUP_M3_CLKCTRL' ${base} 0xB0
  show_reg 'CM_WKUP_UART0_CLKCTRL' ${base} 0xB4
  show_reg 'CM_WKUP_I2C0_CLKCTRL' ${base} 0xB8
  show_reg 'CM_WKUP_ADC_TSC_CLKCTRL' ${base} 0xBC
  show_reg 'CM_WKUP_SMARTREFLEX0_CLKCTRL' ${base} 0xC0
  show_reg 'CM_WKUP_TIMER1_CLKCTRL' ${base} 0xC4
  show_reg 'CM_WKUP_SMARTREFLEX1_CLKCTRL' ${base} 0xC8
  show_reg 'CM_L4_WKUP_AON_CLKSTCTRL' ${base} 0xCC
  show_reg 'CM_WKUP_WDT1_CLKCTRL' ${base} 0xD4
  show_reg 'CM_DIV_M6_DPLL_CORE' ${base} 0xD8
}

show_cm_dpll()
{
  local base=0x44E00500

  show_reg 'CLKSEL_TIMER7_CLK' ${base} 0x4
  show_reg 'CLKSEL_TIMER2_CLK' ${base} 0x8
  show_reg 'CLKSEL_TIMER3_CLK' ${base} 0xC
  show_reg 'CLKSEL_TIMER4_CLK' ${base} 0x10
  show_reg 'CM_MAC_CLKSEL' ${base} 0x14
  show_reg 'CLKSEL_TIMER5_CLK' ${base} 0x18
  show_reg 'CLKSEL_TIMER6_CLK' ${base} 0x1C
  show_reg 'CM_CPTS_RFT_CLKSEL' ${base} 0x20
  show_reg 'CLKSEL_TIMER1MS_CLK' ${base} 0x28
  show_reg 'CLKSEL_GFX_FCLK' ${base} 0x2C
  show_reg 'CLKSEL_PRU_ICSS_OCP_CLK' ${base} 0x30
  show_reg 'CLKSEL_LCDC_PIXEL_CLK' ${base} 0x34
  show_reg 'CLKSEL_WDT1_CLK' ${base} 0x38
  show_reg 'CLKSEL_GPIO0_DBCLK' ${base} 0x3C
}

show_cm_mpu()
{
  local base=0x44E00600

  show_reg 'CM_MPU_CLKSTCTRL' ${base} 0x0
  show_reg 'CM_MPU_MPU_CLKCTRL' ${base} 0x4
}

show_cm_device()
{
  local base=0x44E00700

  show_reg 'CM_CLKOUT_CTRL' ${base} 0x0
}

show_cm_rtc()
{
  local base=0x44E00800

  show_reg 'CM_RTC_RTC_CLKCTRL' ${base} 0x0
  show_reg 'CM_RTC_CLKSTCTRL' ${base} 0x4
}

show_cm_gfx()
{
  local base=0x44E00900

  show_reg 'CM_GFX_L3_CLKSTCTRL' ${base} 0x0
  show_reg 'CM_GFX_GFX_CLKCTRL' ${base} 0x4
  show_reg 'CM_GFX_L4LS_GFX_CLKSTCTRL' ${base} 0xC
  show_reg 'CM_GFX_MMUCFG_CLKCTRL' ${base} 0x10
  show_reg 'CM_GFX_MMUDATA_CLKCTRL' ${base} 0x14
}

show_cm_cefuse()
{
  local base=0x44E00A00

  show_reg 'CM_CEFUSE_CLKSTCTRL' ${base} 0x0
  show_reg 'CM_CEFUSE_CEFUSE_CLKCTRL' ${base} 0x20
}

show_pin_mux()
{
  local base=0x44E10000

  show_reg 'gpmc_ad0' ${base} 0x800
  show_reg 'gpmc_ad1' ${base} 0x804
  show_reg 'gpmc_ad2' ${base} 0x808
  show_reg 'gpmc_ad3' ${base} 0x80C
  show_reg 'gpmc_ad4' ${base} 0x810
  show_reg 'gpmc_ad5' ${base} 0x814
  show_reg 'gpmc_ad6' ${base} 0x818
  show_reg 'gpmc_ad7' ${base} 0x81C
  show_reg 'gpmc_ad8' ${base} 0x820
  show_reg 'gpmc_ad9' ${base} 0x824
  show_reg 'gpmc_ad10' ${base} 0x828
  show_reg 'gpmc_ad11' ${base} 0x82C
  show_reg 'gpmc_ad12' ${base} 0x830
  show_reg 'gpmc_ad13' ${base} 0x834
  show_reg 'gpmc_ad14' ${base} 0x838
  show_reg 'gpmc_ad15' ${base} 0x83C
  show_reg 'gpmc_a0' ${base} 0x840
  show_reg 'gpmc_a1' ${base} 0x844
  show_reg 'gpmc_a2' ${base} 0x848
  show_reg 'gpmc_a3' ${base} 0x84C
  show_reg 'gpmc_a4' ${base} 0x850
  show_reg 'gpmc_a5' ${base} 0x854
  show_reg 'gpmc_a6' ${base} 0x858
  show_reg 'gpmc_a7' ${base} 0x85C
  show_reg 'gpmc_a8' ${base} 0x860
  show_reg 'gpmc_a9' ${base} 0x864
  show_reg 'gpmc_a10' ${base} 0x868
  show_reg 'gpmc_a11' ${base} 0x86C
  show_reg 'gpmc_wait0' ${base} 0x870
  show_reg 'gpmc_wpn' ${base} 0x874
  show_reg 'gpmc_ben1' ${base} 0x878
  show_reg 'gpmc_csn0' ${base} 0x87C
  show_reg 'gpmc_csn1' ${base} 0x880
  show_reg 'gpmc_csn2' ${base} 0x884
  show_reg 'gpmc_csn3' ${base} 0x888
  show_reg 'gpmc_clk' ${base} 0x88C
  show_reg 'gpmc_advn_ale' ${base} 0x890
  show_reg 'gpmc_oen_ren' ${base} 0x894
  show_reg 'gpmc_wen' ${base} 0x898
  show_reg 'gpmc_ben0_cle' ${base} 0x89C
  show_reg 'lcd_data0' ${base} 0x8A0
  show_reg 'lcd_data1' ${base} 0x8A4
  show_reg 'lcd_data2' ${base} 0x8A8
  show_reg 'lcd_data3' ${base} 0x8AC
  show_reg 'lcd_data4' ${base} 0x8B0
  show_reg 'lcd_data5' ${base} 0x8B4
  show_reg 'lcd_data6' ${base} 0x8B8
  show_reg 'lcd_data7' ${base} 0x8BC
  show_reg 'lcd_data8' ${base} 0x8C0
  show_reg 'lcd_data9' ${base} 0x8C4
  show_reg 'lcd_data10' ${base} 0x8C8
  show_reg 'lcd_data11' ${base} 0x8CC
  show_reg 'lcd_data12' ${base} 0x8D0
  show_reg 'lcd_data13' ${base} 0x8D4
  show_reg 'lcd_data14' ${base} 0x8D8
  show_reg 'lcd_data15' ${base} 0x8DC
  show_reg 'lcd_vsync' ${base} 0x8E0
  show_reg 'lcd_hsync' ${base} 0x8E4
  show_reg 'lcd_pclk' ${base} 0x8E8
  show_reg 'lcd_ac_bias_en' ${base} 0x8EC
  show_reg 'mmc0_dat3' ${base} 0x8F0
  show_reg 'mmc0_dat2' ${base} 0x8F4
  show_reg 'mmc0_dat1' ${base} 0x8F8
  show_reg 'mmc0_dat0' ${base} 0x8FC
  show_reg 'mmc0_clk' ${base} 0x900
  show_reg 'mmc0_cmd' ${base} 0x904
  show_reg 'mii1_col' ${base} 0x908
  show_reg 'mii1_crs' ${base} 0x90C
  show_reg 'mii1_rx_er' ${base} 0x910
  show_reg 'mii1_tx_en' ${base} 0x914
  show_reg 'mii1_rx_dv' ${base} 0x918
  show_reg 'mii1_txd3' ${base} 0x91C
  show_reg 'mii1_txd2' ${base} 0x920
  show_reg 'mii1_txd1' ${base} 0x924
  show_reg 'mii1_txd0' ${base} 0x928
  show_reg 'mii1_tx_clk' ${base} 0x92C
  show_reg 'mii1_rx_clk' ${base} 0x930
  show_reg 'mii1_rxd3' ${base} 0x934
  show_reg 'mii1_rxd2' ${base} 0x938
  show_reg 'mii1_rxd1' ${base} 0x93C
  show_reg 'mii1_rxd0' ${base} 0x940
  show_reg 'mii1_ref_clk' ${base} 0x944
  show_reg 'mdio' ${base} 0x948
  show_reg 'mdc' ${base} 0x94C
  show_reg 'spi0_sclk' ${base} 0x950
  show_reg 'spi0_d0' ${base} 0x954
  show_reg 'spi0_d1' ${base} 0x958
  show_reg 'spi0_cs0' ${base} 0x95C
  show_reg 'spi0_cs1' ${base} 0x960
  show_reg 'ecap0_in_pwm0_out' ${base} 0x964
  show_reg 'uart0_ctsn' ${base} 0x968
  show_reg 'uart0_rtsn' ${base} 0x96C
  show_reg 'uart0_rxd' ${base} 0x970
  show_reg 'uart0_txd' ${base} 0x974
  show_reg 'uart1_ctsn' ${base} 0x978
  show_reg 'uart1_rtsn' ${base} 0x97C
  show_reg 'uart1_rxd' ${base} 0x980
  show_reg 'uart1_txd' ${base} 0x984
  show_reg 'i2c0_sda' ${base} 0x988
  show_reg 'i2c0_scl' ${base} 0x98C
  show_reg 'mcasp0_aclkx' ${base} 0x990
  show_reg 'mcasp0_fsx' ${base} 0x994
  show_reg 'mcasp0_axr0' ${base} 0x998
  show_reg 'mcasp0_ahclkr' ${base} 0x99C
  show_reg 'mcasp0_aclkr' ${base} 0x9A0
  show_reg 'mcasp0_fsr' ${base} 0x9A4
  show_reg 'mcasp0_axr1' ${base} 0x9A8
  show_reg 'mcasp0_ahclkx' ${base} 0x9AC
  show_reg 'xdma_event_intr0' ${base} 0x9B0
  show_reg 'xdma_event_intr1' ${base} 0x9B4
  show_reg 'warmrstn' ${base} 0x9B8
  show_reg 'nnmi' ${base} 0x9C0
  show_reg 'tms' ${base} 0x9D0
  show_reg 'tdi' ${base} 0x9D4
  show_reg 'tdo' ${base} 0x9D8
  show_reg 'tck' ${base} 0x9DC
  show_reg 'trstn' ${base} 0x9E0
  show_reg 'emu0' ${base} 0x9E4
  show_reg 'emu1' ${base} 0x9E8
  show_reg 'rtc_pwronrstn' ${base} 0x9F8
  show_reg 'pmic_power_en' ${base} 0x9FC
  show_reg 'ext_wakeup' ${base} 0xA00
  show_reg 'usb0_drvvbus' ${base} 0xA1C
  show_reg 'usb1_drvvbus' ${base} 0xA34
}

show_mcasp()
{
  local base=
  local val=

  if [ $1 -eq 0 ] && [ "$2" = 'data' ]; then
    base=0x46000000
  elif [ $1 -eq 0 ] && [ "$2" = 'cfg' ]; then
    base=0x48038000
  elif [ $1 -eq 1 ] && [ "$2" = 'data' ]; then
    base=0x46400000
  elif [ $1 -eq 1 ] && [ "$2" = 'cfg' ]; then
    base=0x4803c000
  else
    echo 'invalid argument'
    return
  fi

  val=$(read_reg ${base} 0x0) || return
  echo "REV ${val}"

  val=$(read_reg ${base} 0x4)
  echo "PWRIDLESYSCONFIG ${val}"
  echo " IDELMODE $((val & 3))"

  val=$(read_reg ${base} 0x10)
  echo "PFUNC ${val}"
  echo " AFSR $(((val >> 31) & 1))"
  echo " AHCLKR $(((val >> 30) & 1))"
  echo " ACLKR $(((val >> 29) & 1))"
  echo " AFSX $(((val >> 28) & 1))"
  echo " AHCLKX $(((val >> 27) & 1))"
  echo " ACLKX $(((val >> 26) & 1))"
  echo " AMUTE $(((val >> 25) & 1))"
  echo " AXR3 $(((val >> 3) & 1))"
  echo " AXR2 $(((val >> 2) & 1))"
  echo " AXR1 $(((val >> 1) & 1))"
  echo " AXR0 $(((val >> 0) & 1))"

  val=$(read_reg ${base} 0x14)
  echo "PDIR ${val}"
  echo " AFSR $(((val >> 31) & 1))"
  echo " AHCLKR $(((val >> 30) & 1))"
  echo " ACLKR $(((val >> 29) & 1))"
  echo " AFSX $(((val >> 28) & 1))"
  echo " AHCLKX $(((val >> 27) & 1))"
  echo " ACLKX $(((val >> 26) & 1))"
  echo " AMUTE $(((val >> 25) & 1))"
  echo " AXR3 $(((val >> 3) & 1))"
  echo " AXR2 $(((val >> 2) & 1))"
  echo " AXR1 $(((val >> 1) & 1))"
  echo " AXR0 $(((val >> 0) & 1))"

  val=$(read_reg ${base} 0x18)
  echo "PDOUT ${val}"
  echo " AFSR $(((val >> 31) & 1))"
  echo " AHCLKR $(((val >> 30) & 1))"
  echo " ACLKR $(((val >> 29) & 1))"
  echo " AFSX $(((val >> 28) & 1))"
  echo " AHCLKX $(((val >> 27) & 1))"
  echo " ACLKX $(((val >> 26) & 1))"
  echo " AMUTE $(((val >> 25) & 1))"
  echo " AXR3 $(((val >> 3) & 1))"
  echo " AXR2 $(((val >> 2) & 1))"
  echo " AXR1 $(((val >> 1) & 1))"
  echo " AXR0 $(((val >> 0) & 1))"

  val=$(read_reg ${base} 0x1C)
  echo "PDIN ${val}"
  echo " AFSR $(((val >> 31) & 1))"
  echo " AHCLKR $(((val >> 30) & 1))"
  echo " ACLKR $(((val >> 29) & 1))"
  echo " AFSX $(((val >> 28) & 1))"
  echo " AHCLKX $(((val >> 27) & 1))"
  echo " ACLKX $(((val >> 26) & 1))"
  echo " AMUTE $(((val >> 25) & 1))"
  echo " AXR3 $(((val >> 3) & 1))"
  echo " AXR2 $(((val >> 2) & 1))"
  echo " AXR1 $(((val >> 1) & 1))"
  echo " AXR0 $(((val >> 0) & 1))"

  val=$(read_reg ${base} 0x20)
  echo "PDCLR ${val}"
  echo " AFSR $(((val >> 31) & 1))"
  echo " AHCLKR $(((val >> 30) & 1))"
  echo " ACLKR $(((val >> 29) & 1))"
  echo " AFSX $(((val >> 28) & 1))"
  echo " AHCLKX $(((val >> 27) & 1))"
  echo " ACLKX $(((val >> 26) & 1))"
  echo " AMUTE $(((val >> 25) & 1))"
  echo " AXR3 $(((val >> 3) & 1))"
  echo " AXR2 $(((val >> 2) & 1))"
  echo " AXR1 $(((val >> 1) & 1))"
  echo " AXR0 $(((val >> 0) & 1))"

  val=$(read_reg ${base} 0x44)
  echo "GBLCTL ${val}"
  echo " XFRST $(((val >> 12) & 1))"
  echo " XSMRST $(((val >> 11) & 1))"
  echo " XSRCLR $(((val >> 10) & 1))"
  echo " XHCLKRST $(((val >> 9) & 1))"
  echo " XCLKRST $(((val >> 8) & 1))"
  echo " RFRST $(((val >> 4) & 1))"
  echo " RSMRST $(((val >> 3) & 1))"
  echo " RSRCLR $(((val >> 2) & 1))"
  echo " RHCLKRST $(((val >> 1) & 1))"
  echo " RCLKRST $(((val >> 0) & 1))"

  val=$(read_reg ${base} 0x48)
  echo "AMUTE ${val}"
  echo "  XDMAERR $(((val >> 12) & 1))"
  echo "  RDMAERR $(((val >> 11) & 1))"
  echo "  XCKFAIL $(((val >> 10) & 1))"
  echo "  RCKFAIL $(((val >> 9) & 1))"
  echo "  XSYNCERR $(((val >> 8) & 1))"
  echo "  RSYNCERR $(((val >> 7) & 1))"
  echo "  XUNDRN $(((val >> 6) & 1))"
  echo "  ROVRN $(((val >> 5) & 1))"
  echo " *INSTAT $(((val >> 4) & 1))"
  echo "  INEN $(((val >> 3) & 1))"
  echo "  INPOL $(((val >> 2) & 1))"
  echo "  MUTEN $(((val >> 0) & 3))"

  val=$(read_reg ${base} 0x4C)
  echo "DLBCTL ${val}"
  echo "  MODE $(((val >> 2) & 3))"
  echo "  ORD $(((val >> 1) & 1))"
  echo "  DLBEN $(((val >> 0) & 1))"

  val=$(read_reg ${base} 0x50)
  echo "DITCTL ${val}"
  echo "  VB $(((val >> 1) & 3))"
  echo "  VA $(((val >> 1) & 2))"
  echo "  DITEN $(((val >> 1) & 0))"

  val=$(read_reg ${base} 0x60)
  echo "RGBLCTL ${val}"
  echo " *XFRST $(((val >> 12) & 1))"
  echo " *XSMRST $(((val >> 11) & 1))"
  echo " *XSRCLR $(((val >> 10) & 1))"
  echo " *XHCLKRST $(((val >> 9) & 1))"
  echo " *XCLKRST $(((val >> 8) & 1))"
  echo "  RFRST $(((val >> 4) & 1))"
  echo "  RSMRST $(((val >> 3) & 1))"
  echo "  RSRCLR $(((val >> 2) & 1))"
  echo "  RHCLKRST $(((val >> 1) & 1))"
  echo "  RCLKRST $(((val >> 0) & 1))"

  val=$(read_reg ${base} 0x64)
  echo "RMASK ${val}"

  val=$(read_reg ${base} 0x68)
  echo "RFMT ${val}"
  echo "  RDATDLY $(((val >> 16) & 3))"
  echo "  RRVRS $(((val >> 15) & 1))"
  echo "  RPAD $(((val >> 13) & 3))"
  echo "  RPBIT $(((val >> 8) & 0x1F))"
  echo "  RSSZ $(((val >> 4) & 0xF))"
  echo "  RBUSEL $(((val >> 3) & 1))"
  echo "  RROT $(((val >> 0) & 7))"

  val=$(read_reg ${base} 0x6C)
  echo "AFSRCTL ${val}"
  echo "  RMOD $(((val >> 7) & 0x1FF))"
  echo "  FRWID $(((val >> 4) & 1))"
  echo "  FSRM $(((val >> 1) & 1))"
  echo "  FSRP $(((val >> 0) & 1))"

  val=$(read_reg ${base} 0x70)
  echo "ACLKRCTL ${val}"
  echo "  CLKRP $(((val >> 7) & 1))"
  echo "  CLKRM $(((val >> 5) & 1))"
  echo "  CLKRDIV $(((val >> 0) & 0x1F))"

  val=$(read_reg ${base} 0x74)
  echo "AHCLKRCTL ${val}"
  echo "  HCLKRM $(((val >> 15) & 1))"
  echo "  HCLKRP $(((val >> 14) & 1))"
  echo "  HCLKRDIV $(((val >> 0) & 0xFFF))"

  val=$(read_reg ${base} 0x78)
  echo "RTDM ${val}"

  val=$(read_reg ${base} 0x7C)
  echo "RINTCTL ${val}"
  echo "  RSTAMRM $(((val >> 7) & 1))"
  echo "  RDAGTA $(((val >> 5) & 1))"
  echo "  RLAST $(((val >> 4) & 1))"
  echo "  RDMAERR $(((val >> 3) & 1))"
  echo "  RCKFAIL $(((val >> 2) & 1))"
  echo "  RSYNCERR $(((val >> 1) & 1))"
  echo "  ROVRN $(((val >> 0) & 1))"

  val=$(read_reg ${base} 0x80)
  echo "RSTAT ${val}"
  echo "  RERR $(((val >> 8) & 1))"
  echo "  RDMAERR $(((val >> 7) & 1))"
  echo "  RSTAFRM $(((val >> 6) & 1))"
  echo "  RDATA $(((val >> 5) & 1))"
  echo "  RLAST $(((val >> 4) & 1))"
  echo " *RTDMSLOT $(((val >> 3) & 1))"
  echo "  RCKFAIL $(((val >> 2) & 1))"
  echo "  RSYNCERR $(((val >> 1) & 1))"
  echo "  ROVRN $(((val >> 0) & 1))"

  val=$(read_reg ${base} 0x84)
  echo "RSLOT ${val}"
  echo " *RSLOTCNT $(((val >> 0) & 0x1FF))"

  val=$(read_reg ${base} 0x88)
  echo "RCLKCHK ${val}"
  echo "  RCNT $(((val >> 24) & 0xFF))"
  echo "  RMAX $(((val >> 16) & 0xFF))"
  echo "  RMIN $(((val >> 8) & 0xFF))"
  echo "  RPS $(((val >> 0) & 0xF))"

  val=$(read_reg ${base} 0x8C)
  echo "REVTCTL ${val}"
  echo "  RDATDMA $(((val >> 0) & 1))"

  val=$(read_reg ${base} 0xA0)
  echo "XGBLCTL ${val}"
  echo "  XFRST $(((val >> 12) & 1))"
  echo "  XSMRST $(((val >> 11) & 1))"
  echo "  XSRCLR $(((val >> 10) & 1))"
  echo "  XHCLKRST $(((val >> 9) & 1))"
  echo "  XCLKRST $(((val >> 8) & 1))"
  echo " *RFRST $(((val >> 4) & 1))"
  echo " *RSMRST $(((val >> 3) & 1))"
  echo " *RSRCLR $(((val >> 2) & 1))"
  echo " *RHCLKRST $(((val >> 1) & 1))"
  echo " *RCLKRST $(((val >> 0) & 1))"

  val=$(read_reg ${base} 0xA4)
  echo "XMASK ${val}"

  val=$(read_reg ${base} 0xA8)
  echo "XFMT ${val}"
  echo "  XDATDLY $(((val >> 16) & 3))"
  echo "  XRVRS $(((val >> 15) & 1))"
  echo "  XPAD $(((val >> 13) & 3))"
  echo "  XPBIT $(((val >> 8) & 0x1F))"
  echo "  XSSZ $(((val >> 4) & 0xF))"
  echo "  XBUSEL $(((val >> 3) & 1))"
  echo "  XROT $(((val >> 0) & 7))"

  val=$(read_reg ${base} 0xAC)
  echo "AFSXCTL ${val}"
  echo "  XMOD $(((val >> 7) & 0x1FF))"
  echo "  FXWID $(((val >> 4) & 1))"
  echo "  FSXM $(((val >> 1) & 1))"
  echo "  FSXP $(((val >> 0) & 1))"

  val=$(read_reg ${base} 0xB0)
  echo "ACLKXCTL ${val}"
  echo "  CLKXP $(((val >> 7) & 1))"
  echo "  ASYNC $(((val >> 6) & 1))"
  echo "  CLKXM $(((val >> 5) & 1))"
  echo "  CLKXDIV $(((val >> 0) & 0x1F))"

  val=$(read_reg ${base} 0xB4)
  echo "AHCLKXCTL ${val}"
  echo "  HCLKXM $(((val >> 15) & 1))"
  echo "  HCLKXP $(((val >> 14) & 1))"
  echo "  HCLKXDIV $(((val >> 11) & 0xFFF))"

  val=$(read_reg ${base} 0xB8)
  echo "XTDM ${val}"

  val=$(read_reg ${base} 0xBC)
  echo "XINTCTL ${val}"
  echo "  XSTAFRM $(((val >> 7) & 1))"
  echo "  XDATA $(((val >> 5) & 1))"
  echo "  XLAST $(((val >> 4) & 1))"
  echo "  XDMAERR $(((val >> 3) & 1))"
  echo "  XCKFAIL $(((val >> 2) & 1))"
  echo "  XSYNCERR $(((val >> 1) & 1))"
  echo "  XUNDRN $(((val >> 0) & 1))"

  val=$(read_reg ${base} 0xC0)
  echo "XSTAT ${val}"
  echo "  XERR $(((val >> 8) & 1))"
  echo "  XDMAERR $(((val >> 7) & 1))"
  echo "  XSTAFRM $(((val >> 6) & 1))"
  echo "  XDATA $(((val >> 5) & 1))"
  echo "  XLAST $(((val >> 4) & 1))"
  echo " *XTDMSLOT $(((val >> 3) & 1))"
  echo "  XCKFAIL $(((val >> 2) & 1))"
  echo "  XSYNCERR $(((val >> 1) & 1))"
  echo "  XUNDRN $(((val >> 0) & 1))"

  val=$(read_reg ${base} 0xC4)
  echo "XSLOT ${val}"
  echo " *XSLOTCNT $(((val >> 0) & 0x3FF))"

  val=$(read_reg ${base} 0xC8)
  echo "XCLKCHK ${val}"
  echo " *XCNT $(((val >> 24) & 0xFF))"
  echo "  XMAX $(((val >> 16) & 0xFF))"
  echo "  XMIN $(((val >> 8) & 0xFF))"
  echo "  XPS $(((val >> 0) & 0xF))"

  val=$(read_reg ${base} 0xCC)
  echo "XEVTCTL ${val}"
  echo "  XDATDMA $(((val >> 0) & 1))"

  val=$(read_reg ${base} 0x100)
  echo "DITCSRA_0 ${val}"
  val=$(read_reg ${base} 0x104)
  echo "DITCSRA_1 ${val}"
  val=$(read_reg ${base} 0x108)
  echo "DITCSRA_2 ${val}"
  val=$(read_reg ${base} 0x10C)
  echo "DITCSRA_3 ${val}"
  val=$(read_reg ${base} 0x110)
  echo "DITCSRA_4 ${val}"
  val=$(read_reg ${base} 0x114)
  echo "DITCSRA_5 ${val}"

  val=$(read_reg ${base} 0x118)
  echo "DITCSRB_0 ${val}"
  val=$(read_reg ${base} 0x11C)
  echo "DITCSRB_1 ${val}"
  val=$(read_reg ${base} 0x120)
  echo "DITCSRB_2 ${val}"
  val=$(read_reg ${base} 0x124)
  echo "DITCSRB_3 ${val}"
  val=$(read_reg ${base} 0x128)
  echo "DITCSRB_4 ${val}"
  val=$(read_reg ${base} 0x12C)
  echo "DITCSRB_5 ${val}"

  val=$(read_reg ${base} 0x130)
  echo "DITUDRA_0 ${val}"
  val=$(read_reg ${base} 0x134)
  echo "DITUDRA_1 ${val}"
  val=$(read_reg ${base} 0x138)
  echo "DITUDRA_2 ${val}"
  val=$(read_reg ${base} 0x13C)
  echo "DITUDRA_3 ${val}"
  val=$(read_reg ${base} 0x140)
  echo "DITUDRA_4 ${val}"
  val=$(read_reg ${base} 0x144)
  echo "DITUDRA_5 ${val}"

  val=$(read_reg ${base} 0x148)
  echo "DITUDRB_0 ${val}"
  val=$(read_reg ${base} 0x14C)
  echo "DITUDRB_1 ${val}"
  val=$(read_reg ${base} 0x150)
  echo "DITUDRB_2 ${val}"
  val=$(read_reg ${base} 0x154)
  echo "DITUDRB_3 ${val}"
  val=$(read_reg ${base} 0x158)
  echo "DITUDRB_4 ${val}"
  val=$(read_reg ${base} 0x15C)
  echo "DITUDRB_5 ${val}"

  val=$(read_reg ${base} 0x180)
  echo "SRCTL_0 ${val}"
  echo " *RRDY $(((val >> 5) & 1))"
  echo " *XRDY $(((val >> 4) & 1))"
  echo "  DISMOD $(((val >> 2) & 3))"
  echo "  SRMOD $(((val >> 0) & 3))"

  val=$(read_reg ${base} 0x184)
  echo "SRCTL_1 ${val}"
  echo " *RRDY $(((val >> 5) & 1))"
  echo " *XRDY $(((val >> 4) & 1))"
  echo "  DISMOD $(((val >> 2) & 3))"
  echo "  SRMOD $(((val >> 0) & 3))"

  val=$(read_reg ${base} 0x188)
  echo "SRCTL_2 ${val}"
  echo " *RRDY $(((val >> 5) & 1))"
  echo " *XRDY $(((val >> 4) & 1))"
  echo "  DISMOD $(((val >> 2) & 3))"
  echo "  SRMOD $(((val >> 0) & 3))"

  val=$(read_reg ${base} 0x18C)
  echo "SRCTL_3 ${val}"
  echo " *RRDY $(((val >> 5) & 1))"
  echo " *XRDY $(((val >> 4) & 1))"
  echo "  DISMOD $(((val >> 2) & 3))"
  echo "  SRMOD $(((val >> 0) & 3))"

  val=$(read_reg ${base} 0x190)
  echo "SRCTL_4 ${val}"
  echo " *RRDY $(((val >> 5) & 1))"
  echo " *XRDY $(((val >> 4) & 1))"
  echo "  DISMOD $(((val >> 2) & 3))"
  echo "  SRMOD $(((val >> 0) & 3))"

  val=$(read_reg ${base} 0x194)
  echo "SRCTL_5 ${val}"
  echo " *RRDY $(((val >> 5) & 1))"
  echo " *XRDY $(((val >> 4) & 1))"
  echo "  DISMOD $(((val >> 2) & 3))"
  echo "  SRMOD $(((val >> 0) & 3))"

  val=$(read_reg ${base} 0x200)
  echo "XBUF_0 ${val}"
  val=$(read_reg ${base} 0x204)
  echo "XBUF_1 ${val}"
  val=$(read_reg ${base} 0x208)
  echo "XBUF_2 ${val}"
  val=$(read_reg ${base} 0x20C)
  echo "XBUF_3 ${val}"
  val=$(read_reg ${base} 0x210)
  echo "XBUF_4 ${val}"
  val=$(read_reg ${base} 0x214)
  echo "XBUF_5 ${val}"

  val=$(read_reg ${base} 0x280)
  echo "RBUF_0 ${val}"
  val=$(read_reg ${base} 0x284)
  echo "RBUF_1 ${val}"
  val=$(read_reg ${base} 0x288)
  echo "RBUF_2 ${val}"
  val=$(read_reg ${base} 0x28C)
  echo "RBUF_3 ${val}"
  val=$(read_reg ${base} 0x290)
  echo "RBUF_4 ${val}"
  val=$(read_reg ${base} 0x294)
  echo "RBUF_5 ${val}"

  val=$(read_reg ${base} 0x1000)
  echo "WFIFOCTL ${val}"
  echo "  WENA $(((val >> 16) & 1))"
  echo "  WNUMEVT $(((val >> 8) & 0xFF))"
  echo "  WNUMDMA $(((val >> 0) & 0xFF))"

  val=$(read_reg ${base} 0x1004)
  echo "WFIFOSTS ${val}"
  echo " *WLVL $(((val >> 0) & 0xFF))"

  val=$(read_reg ${base} 0x1008)
  echo "RFIFOCTL ${val}"
  echo "  RENA $(((val >> 16) & 1))"
  echo "  RNUMEVT $(((val >> 8) & 0xFF))"
  echo "  RNUMDMA $(((val >> 0) & 0xFF))"

  val=$(read_reg ${base} 0x100C)
  echo "RFIFOSTS ${val}"
  echo " *RLVL $(((val >> 0) & 0xFF))"
}

main()
{
  if type devmem &> /dev/null; then
    g_devmem=y
    g_devmem_cmd='devmem'
  elif type devmem2 &> /dev/null; then
    g_devmem2=y
    g_devmem_cmd='devmem2'
  fi

  if [ ! "${g_devmem_cmd}" ]; then
    echo 'devmem or devmem2 is required'
    exit 1
  fi

  if [ $# -eq 0 ]; then
    echo "usage: $0 <block-name>..."
    echo
    echo "Valid block name:"
    echo "cm-per"
    echo "cm-wkup"
    echo "cm-dpll"
    echo "cm-mpu"
    echo "cm-device"
    echo "cm-rtc"
    echo "cm-gfx"
    echo "cm-cefuse"
    echo "pinmux"
    echo "mcasp0-data"
    echo "mcasp0-cfg"
    echo "mcasp1-data"
    echo "mcasp1-cfg"
    exit 1
  fi

  local arg=

  for arg; do
    case "${arg}" in
      cm-per)
        show_cm_per ;;
      cm-wkup)
        show_cm_wkup ;;
      cm-dpll)
        show_cm_dpll ;;
      cm-mpu)
        show_cm_mpu ;;
      cm-device)
        show_cm_device ;;
      cm-rtc)
        show_cm_rtc ;;
      cm-gfx)
        show_cm_gfx ;;
      cm-cefuse)
        show_cm_cefuse ;;
      pinmux)
        show_pin_mux ;;
      mcasp0-data)
        show_mcasp 0 data ;;
      mcasp0-cfg)
        show_mcasp 0 cfg ;;
      mcasp1-data)
        show_mcasp 1 data ;;
      mcasp1-cfg)
        show_mcasp 1 cfg ;;
      *)
        echo "${arg}: unknown block name" ;;
    esac
  done
}

main "$@"
