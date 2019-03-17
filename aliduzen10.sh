#!/bin/bash
clear
function main_menu()
{
    while :
    do
        echo
        echo "Ana Sayfa"
        echo
        echo "1. Start optimization"
        echo "2. Panel Optimization"
        echo "3. Security Optimization"
        echo "4. Çıkış Yap"
        echo
        read -p "Choice: " m_choice
        echo

        case "$m_choice" in
            1) clear
               sub_menu

                ;;
            2)  echo "Panel Optimization"
                clear
                ;;
            3)  echo "Security Optimization"
                clear
                ;;
            4)  clear
                exit 0
                ;;
            *)  clear
                echo "Hatalı İşlem girdisi girdiniz. Lütfen tekrar deneyin."
                ;;
        esac
    done
}
clear
function sub_menu()
{
    while :
    do
        echo
        echo "Start optimization"
        echo
        echo "1. Basic Optimization"
        echo "2. Ram Disk Creating"
        echo "3. Geri Dön"
        read -p "Choice: " s_choice
        echo

        case "$s_choice" in
            1)  echo "Basic Optimization"
                clear
                cat /etc/issue |awk '{ if ($3 ~ /7/) print $3} { if ($4 ~ /6/) print $4} { if ($3 ~ /5./) print $3} { if ($3 ~ /6/) print $3}' > /root/aliduzen100.txt
                chmod 777 /root/aliduzen100.txt
                lcontrol=/root/aliduzen100.txt
                     IP=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' |head -1)
                     centos6="6"
                     centos7="7"
                     coneth=$(find /etc/sysconfig/network-scripts/ -name "ifcfg-e*")
                     RED='\033[0;32m'
                     NC='\033[0m' # No Color
                     printf "Aliduzen10 Beta Version ${RED}(OK)${NC}\n"
      ###################### Centos 6 ########################
                     if grep -q "$centos6" "$lcontrol"; then
                     echo "CentOS 6 Tespit Edildi" #/ Renk verilecek
                     echo "Configure edilecek dosyalarınız yedekleniyor."
                     cp -p /etc/sysconfig/network /etc/sysconfig/network.backup.`date +%Y.%m.%d.%H.%M.%S`
                     cp -p /etc/hosts /etc/hosts.backup.`date +%Y.%m.%d.%H.%M.%S`
                     cp -p /etc/resolver.conf /etc/resolver.conf.backup.`date +%Y.%m.%d.%H.%M.%S`
                     cp -p /etc/selinux/config /etc/selinux/config.backup.`date +%Y.%m.%d.%H.%M.%S`
                     cp -p /etc/ssh/sshd_config /etc/ssh/sshd_config.backup.`date +%Y.%m.%d.%H.%M.%S`
                     echo "/etc/sysconfig/network dosyanız derlenmektedir." # Bilgilendirme = İşlem 1 = Networks
                     echo -e "`hostname`" > /etc/sysconfig/network
                     echo "NETWORKING=yes" >> /etc/sysconfig/network
                     echo "NETWORKING_IPV6=no" >> /etc/sysconfig/network
                     grep GATEWAY= $coneth >> /etc/sysconfig/network
                     echo -ne '#############               (38%)\r'
                     sleep 1
                     echo -ne '####################        (61%)\r'
                     sleep 1
                     echo -ne '########################### (100%)\r'
                     echo -ne '\n'
                     printf "/etc/sysconfig/network Dosyanız başarı ile konfigure edilmiştir.${RED}(OK)${NC}\n"
                     echo "Hosts dosyanız derlenmektedir." # Bilgilendirme = İşlem 2 = Hosts
                     echo "127.0.0.1       localhost.localdomain    localhost" > /etc/hosts
                     echo "$IP   `hostname`      server " >> /etc/hosts
                     echo -ne '#############               (38%)\r'
                     sleep 1
                     echo -ne '####################        (61%)\r'
                     sleep 1
                     echo -ne '########################### (100%)\r'
                     echo -ne '\n'
                     printf "/etc/hosts Dosyanız başarı ile konfigure edilmiştir.${RED}(OK)${NC}\n"
                     echo "/etc/resolver.conf dosyanız derlenmektedir." # Bilgilendirme = İşlem 3 = Resolver
                     echo "options single-request-reopen" > /etc/resolver.conf
                     echo "nameserver 91.191.170.20 " >> /etc/resolver.conf
                     echo "nameserver 91.191.170.21 " >> /etc/resolver.conf
                     echo -ne '#############               (38%)\r'
                     sleep 1
                     echo -ne '####################        (61%)\r'
                     sleep 1
                     echo -ne '########################### (100%)\r'
                     echo -ne '\n'
                     printf "/etc/resolver.conf Dosyanız başarı ile konfigure edilmiştir.${RED}(OK)${NC}\n"
                     oldselinux=$(grep -m1 "SELINUX" /etc/selinux/config)
                     sed -i "s/$oldselinux/SELINUX=disabled/g"  /etc/selinux/config
                     echo -ne '#############               (50%)\r'
                     sleep 1
                     echo -ne '########################### (100%)\r'
                     echo -ne '\n'
                     printf "Selinux Dosyanız başarı ile konfigure edilmiştir.${RED}(OK)${NC}\n"
                    while true; do
    read -p "$SSH Portunun değiştirilmesini istemektemisiniz ? [Y: Evet N: Hayır]: " yn # Bilgilendirme = İşlem 5 = SSH portu değiştirilme
    case $yn in
        [Yy]* )      read -p "Lütfen SSH Portunu Belirtiniz: " sshport
                     oldsshport=$(grep -m1 "Port" /etc/ssh/sshd_config)
                     sed -i "s/$oldsshport/Port $sshport/g"  /etc/ssh/sshd_config
                     echo "SSH portunuz $sshport olarak değiştirilmiştir."
                     service sshd restart
                     echo "Sunucu update edilecektir."
                     yum update -y
                     yum install mlocate -y
                     updatedb
                     yum install wget nano -y
                     echo "Update işlemi tamamlanmıştır." ; break;;
        [Nn]* ) echo "Sunucu update edilecektir."
        yum update -y
        yum install mlocate -y
        updatedb
        yum install wget nano -y
        echo "Update işlemi tamamlanmıştır."
        echo "Yapılan değişikliklerin geçerli olabilmesi adına sunucunuzu restart ediniz." ; break;;
        * ) echo "Lütfen sadece yes(y) or no.(n)";;
    esac
done
########################################## CentOS 7 ########################################
                    elif grep -q "$centos7" "$lcontrol" || grep -q "$cloudlinux7" "$lcontrol" ; then # Belirgin olması için değişken ile cloudlinux6, centos6 yazılmıştır.
                    echo "CentOS 7 Tespit Edildi" #/ Renk verilecek
                    echo "Configure edilecek dosyalarınız yedekleniyor."
                cp -p /etc/sysconfig/network /etc/sysconfig/network.backup.`date +%Y.%m.%d.%H.%M.%S`
             cp -p /etc/hosts /etc/hosts.backup.`date +%Y.%m.%d.%H.%M.%S`
          cp -p /etc/resolver.conf /etc/resolver.conf.backup.`date +%Y.%m.%d.%H.%M.%S`
      cp -p /etc/selinux/config /etc/selinux/config.backup.`date +%Y.%m.%d.%H.%M.%S`
  cp -p /etc/ssh/sshd_config //etc/ssh/sshd_config.backup.`date +%Y.%m.%d.%H.%M.%S`
                    echo "/etc/sysconfig/network dosyanız derlenmektedir." # Bilgilendirme = İşlem 1 = Networks
                     echo -e "`hostname`" > /etc/sysconfig/network
                      echo "NETWORKING=yes" >> /etc/sysconfig/network
                       echo "NETWORKING_IPV6=no" >> /etc/sysconfig/network
               grep GATEWAY= $coneth >> /etc/sysconfig/network
                  echo -ne '#############               (38%)\r'
                  sleep 1
                     echo -ne '####################        (61%)\r'
                  sleep 1
                    echo -ne '########################### (100%)\r'
                  echo -ne '\n'
              printf "/etc/sysconfig/network Dosyanız başarı ile konfigure edilmiştir.${RED}(OK)${NC}\n"
                     echo "Hosts dosyanız derlenmektedir." # Bilgilendirme = İşlem 2 = Hosts
                    echo "127.0.0.1       localhost.localdomain    localhost" > /etc/hosts
                     echo "$IP   `hostname`      server " >> /etc/hosts
                    echo -ne '#############               (38%)\r'
                  sleep 1
                     echo -ne '####################        (61%)\r'
                  sleep 1
                    echo -ne '########################### (100%)\r'
                     echo -ne '\n'
              printf "/etc/hosts Dosyanız başarı ile konfigure edilmiştir.${RED}(OK)${NC}\n"
                    echo "/etc/resolver.conf dosyanız derlenmektedir." # Bilgilendirme = İşlem 3 = Resolver
                     echo "options single-request-reopen" > /etc/resolv.conf
                    echo "nameserver 91.191.170.20 " >> /etc/resolv.conf
                     echo "nameserver 91.191.170.21 " >> /etc/resolv.conf
                    echo -ne '#############               (38%)\r'
                  sleep 1
                     echo -ne '####################        (61%)\r'
                  sleep 1
                    echo -ne '########################### (100%)\r'
                     echo -ne '\n'
              printf "/etc/resolver.conf Dosyanız başarı ile konfigure edilmiştir.${RED}(OK)${NC}\n"
                    echo "Selinux disable ediliyor..." # Bilgilendirme = İşlem 4 = Selinux
                    oldselinux=$(grep -m1 "SELINUX" /etc/selinux/config)
                    sed -i "s/$oldselinux/SELINUX=disabled/g"  /etc/selinux/config
                    echo -ne '#############               (50%)\r'
                    sleep 1
                    echo -ne '########################### (100%)\r'
                    echo -ne '\n'
                    printf "Selinux Dosyanız başarı ile konfigure edilmiştir.${RED}(OK)${NC}\n"
                   while true; do
   read -p "$SSH Portunun değiştirilmesini istemektemisiniz ? [Y: Evet N: Hayır]: " yn # Bilgilendirme = İşlem 5 = SSH portu değiştirilme
   case $yn in
       [Yy]* )
                   read -p "Lütfen SSH Portunu Belirtiniz : " sshport
                    oldsshport=$(grep -m1 "Port" /etc/ssh/sshd_config)
                    sed -i "s/$oldsshport/Port $sshport/g"  /etc/ssh/sshd_config
                    echo "SSH portunuz $sshport olarak değiştirilmiştir."
                    service sshd restart
                    echo "Sunucu update edilecektir."
                    yum update -y
                    yum install mlocate -y
                    updatedb
                    yum install wget nano -y
                    echo "Update işlemi tamamlanmıştır." ; break;;
       [Nn]* ) echo "Sunucu update edilecektir."
       yum update -y
       yum install mlocate -y
       updatedb
       yum install wget nano -y
       echo "Update işlemi tamamlanmıştır." ; break;;
       * ) echo "Lütfen sadece yes(y) or no.(n)";;
   esac
done
                fi
                ;;
            2)  echo "Ram Disk Creating"
                clear
                cat /etc/issue |awk '{ if ($3 ~ /7/) print $3} { if ($4 ~ /6/) print $4} { if ($3 ~ /5./) print $3} { if ($3 ~ /6/) print $3}' > /root/aliduzen100.txt
                chmod 777 /root/aliduzen100.txt
                lcontrol=/root/aliduzen100.txt #Farklı bir OS kontrol işlemi bulunmakta şuanda test aşamasında beta sürüm sonrası kontrol mekanizması değiştirilecektir.
                ubuntu="Ubuntu"
                centos6="6"
                centos7="7"
                mem=$(free -m | grep -oP '\d+' | head -n 1)
                if [ "$mem" -ge 0 ] && [ "$mem" -le 2048 ]; then
                    echo "Ram Disk kapasinetiniz yeterli bulunmamaktadır."
                    echo "Yapılacak bir işlem sunucunuzu yavaşlatabilir veya düzgün çalışmamasına sebep olabilir."
                fi
                ##################### CentOS 7 ###############################
                if grep -q "$centos7" "$lcontrol"; then
                echo "Centos 7 or cloudlinux7 Tespit edildi."
                echo "Mevcut RAM kapasiteniz $mem mb olarak gözlenmiştir."
                echo "Sistem tarafından ramdisk kapasitesi 1024 mb olarak tanımlanacaktır."
                echo "farklı bir tanımlama gerçekleştirmek istiyor iseniz Evet (y)"
                echo "Devam etmek istiyor iseniz Hayır (n) Tuşluyabilirsiniz."
                read -p "Seçiminiz: " onay
                if [ "$onay" == "y" ]; then
                  echo "Tanımlamak istediğiniz kapasiteyi belirleyin."
                  echo "NOT: Lütfen Megabyte (MB) cinsinden belirtiniz. Örnek: 1024,2048,4096 vb."
                read -p "Belirlenen Kapasite : " kapasite
                  if ["$mem" -gt "$kapasite"]; then #BÜYÜKTÜR
                    echo "Onaylandı"
                    islem="1"
                  elif ["$mem" -lt "$kapasite"]; then #küçüktür
                    echo "Onaylanmadı"
                    islem="2"
                   fi
                    case "$islem" in
                      1)
                           echo "Onaylandı"; # kişi tarafından tanımlanan miktar tanımlanacaktır.
                           echo "Ram kapasiteniz $mem MB olarak gözlenmiştir. Ram disk işlemine başlanıyor."
                           echo "MB cinsinden örnek: 1024m, 4096m vb."
                           read -p "Belirlenen Kapasite : " kapasite
                           mkdir /root/ramdisk
                           mount -t tmpfs -o size=$kapasite tmpfs /ramdisk
                           chmod 777 /root/ramdisk
                           if [ -f "$sqlmycnf" ]; then
                         cp /etc/my.cnf /etc/my.cnf.backup.`date +%Y.%m.%d.%H.%M.%S`
                         echo "tmpdir=/ramdisk" >> /etc/my.cnf
                         systemctl restart mysqld
                         fi
                           ;;
                      2)
                           echo "Onaylanmadı"; # yazılan ram miktarı toplam kapasiten büyük TEKRAR GİR.
                           echo "Tanımladığınız alan toplam ram kapasitenizi aşmaktadır. Lütfen tekrar deneyin."
                           ;;
                      *)
                           echo "Hatalı işlem"; # Hatalı işlem TEKRAR GİR.
                           echo "Lütfen tekrar deneyin."
                           ;;
                   esac
                elif [ "$onay" == "n" ]; then #ram OTOMASYON tarafından tanımlandı
                  echo "Sistem tarafından ramdisk kapasitesi tanımlanıyor..."
                  mkdir /root/ramdisk
                  mount -t tmpfs -o size=1024m tmpfs /ramdisk
                  chmod 777 /root/ramdisk
                  sqlmycnf="/etc/my.cnf"
                    if [ -f "$sqlmycnf" ]; then
                  cp /etc/my.cnf /etc/my.cnf.backup.`date +%Y.%m.%d.%H.%M.%S`
                  echo "tmpdir=/ramdisk" >> /etc/my.cnf
                  systemctl restart mysqld
                  fi
                fi
                ############################## Centos 6 ############################
                elif grep -q "$centos6" "$lcontrol"; then
                echo "Centos 6 or cloudlinux6 Tespit edildi."
                echo "Mevcut RAM kapasiteniz $mem mb olarak gözlenmiştir."
                echo "Sistem tarafından ramdisk kapasitesi 1024 mb olarak tanımlanacaktır."
                echo "farklı bir tanımlama gerçekleştirmek istiyor iseniz Evet (y)"
                echo "Devam etmek istiyor iseniz Hayır (n) Tuşluyabilirsiniz."
                read -p "Seçiminiz: " onay
                if [ "$onay" == "y" ]; then
                  echo "Tanımlamak istediğiniz kapasiteyi belirleyin."
                  echo "NOT: Lütfen Megabyte (MB) cinsinden belirtiniz. Örnek: 1024,2048,4096 vb."
                read -p "Belirlenen Kapasite : " kapasite
                  if ["$mem" -gt "$kapasite"]; then #BÜYÜKTÜR
                    echo "Onaylandı"
                    islem="1"
                  elif ["$mem" -lt "$kapasite"]; then #küçüktür
                    echo "Onaylanmadı"
                    islem="2"
                   fi
                    case "$islem" in
                      1)
                           echo "Onaylandı"; # kişi tarafından tanımlanan miktar tanımlanacaktır.
                           echo "Ram kapasiteniz $mem MB olarak gözlenmiştir. Ram disk işlemine başlanıyor."
                           cp /boot/grub/menu.lst /boot/menu.lst.backup.`date +%Y.%m.%d.%H.%M.%S`
                           grub="/boot/grub/menu.lst"
                           if grep -q "ramdisk_size=" "$grub"; then
                           echo "Hali hazırda bir ramdisk alanı tanımlanmış"
                           size=$(expr 1024 '*' "$kapasite")
                           echo "$size"
                           sed -i "s/rhgb quiet/rhgb quiet ramdisk_size=$size/g"  /boot/grub/menu.lst
                           mkfs.ext4 -m 0 /dev/ram0
                           mkdir /root/ramdisk
                           mount /dev/ram0 /root/ramdisk
                           chmod 777 /root/ramdisk
                           echo "Kontrol paneliniz bulunuyor ise mysql tmp directory RAM DİSK olarak eklenecektir."
                           sqlmycnf="/etc/my.cnf"
                             if [ -f "$sqlmycnf" ]; then
                                   cp /etc/my.cnf /etc/my.cnf.backup.`date +%Y.%m.%d.%H.%M.%S`
                                   echo "tmpdir=/ramdisk" >> /etc/my.cnf
                                   /etc/init.d/mysqld restart
                           fi
                           touch /etc/init.d/makeramdisk
                           chmod 755 /etc/init.d/makeramdisk
                           echo "#!/bin/sh" > /etc/init.d/makeramdisk
                           echo "#" >> /etc/init.d/makeramdisk
                           echo "# chkconfig: 2345 90 10" >> /etc/init.d/makeramdisk
                           echo "# description: Ramdisk Create" >> /etc/init.d/makeramdisk
                           echo "#" >> /etc/init.d/makeramdisk
                           echo "# processname:" >> /etc/init.d/makeramdisk
                           echo "# pidfile:" >> /etc/init.d/makeramdisk
                           echo "# config:" >> /etc/init.d/makeramdisk
                           echo "mkfs.ext4 -m 0 /dev/ram0" >> /etc/init.d/makeramdisk
                           echo "[ ! -d /ramdisk ] && mkdir -p /ramdisk" >> /etc/init.d/makeramdisk
                           echo "mount /dev/ram0 /ramdisk" >> /etc/init.d/makeramdisk
                           echo "chmod 777 /root/ramdisk" >> /etc/init.d/makeramdisk
                           chkconfig --list makeramdisk
                           chkconfig --add /etc/init.d/makeramdisk
                           chkconfig --level 2345 makeramdisk on
                           /etc/init.d/makeramdisk start
                           echo "İşlem tamamlanmıştır."
                                 fi
                           ;;
                      2)
                           echo "Onaylanmadı"; # yazılan ram miktarı toplam kapasiten büyük TEKRAR GİR.
                           echo "Tanımladığınız alan toplam ram kapasitenizi aşmaktadır. Lütfen tekrar deneyin."
                           ;;
                      *)
                           echo "Hatalı işlem"; # Hatalı işlem TEKRAR GİR.
                           echo "Lütfen tekrar deneyin."
                           ;;
                   esac
                elif [ "$onay" == "n" ]; then #ram OTOMASYON tarafından tanımlandı
                  echo "Sistem tarafından ramdisk kapasitesi tanımlanıyor..."
                  echo "Ram kapasiteniz $mem MB olarak gözlenmiştir. Ram disk işlemine başlanıyor."
                  cp /boot/grub/menu.lst /boot/menu.lst.backup.`date +%Y.%m.%d.%H.%M.%S`
                  sed -i 's/rhgb quiet/rhgb quiet ramdisk_size=1048576/g'  /boot/grub/menu.lst
                  mkfs.ext4 -m 0 /dev/ram0
                  mkdir /root/ramdisk
                  mount /dev/ram0 /root/ramdisk
                  chmod 777 /root/ramdisk
                  echo "Kontrol paneliniz bulunuyor ise mysql tmp directory RAM DİSK olarak eklenecektir."
                  sqlmycnf="/etc/my.cnf"
                    if [ -f "$sqlmycnf" ]; then
                          cp /etc/my.cnf /etc/my.cnf.backup.`date +%Y.%m.%d.%H.%M.%S`
                          echo "tmpdir=/ramdisk" >> /etc/my.cnf
                          /etc/init.d/mysqld restart
                  fi
                          touch /etc/init.d/makeramdisk
                          chmod 755 /etc/init.d/makeramdisk
                          echo "#!/bin/sh" > /etc/init.d/makeramdisk
                          echo "#" >> /etc/init.d/makeramdisk
                          echo "# chkconfig: 2345 90 10" >> /etc/init.d/makeramdisk
                          echo "# description: Ramdisk Create" >> /etc/init.d/makeramdisk
                          echo "#" >> /etc/init.d/makeramdisk
                          echo "# processname:" >> /etc/init.d/makeramdisk
                          echo "# pidfile:" >> /etc/init.d/makeramdisk
                          echo "# config:" >> /etc/init.d/makeramdisk
                          echo "mkfs.ext4 -m 0 /dev/ram0" >> /etc/init.d/makeramdisk
                          echo "[ ! -d /ramdisk ] && mkdir -p /ramdisk" >> /etc/init.d/makeramdisk
                          echo "mount /dev/ram0 /ramdisk" >> /etc/init.d/makeramdisk
                          echo "chmod 777 /root/ramdisk" >> /etc/init.d/makeramdisk
                          chkconfig --list makeramdisk
                          chkconfig --add /etc/init.d/makeramdisk
                          chkconfig --level 2345 makeramdisk on
                          /etc/init.d/makeramdisk start
                          echo "İşlem tamamlanmıştır."
                fi
                ############################ Ubuntu ######################
              elif grep -q "$ubuntu" "$lcontrol"; then
                echo "ubuntu Tespit edildi."
                echo "Mevcut RAM kapasiteniz $mem mb olarak gözlenmiştir."
                echo "Sistem tarafından ramdisk kapasitesi 1024 mb olarak tanımlanacaktır."
                echo "farklı bir tanımlama gerçekleştirmek istiyor iseniz Evet (y)"
                echo "Devam etmek istiyor iseniz Hayır (n) Tuşluyabilirsiniz."
                read -p "Seçiminiz : " onay
                if [ "$onay" == "y" ]; then
                  echo "Tanımlamak istediğiniz kapasiteyi belirleyin."
                  echo "NOT: Lütfen Megabyte (MB) cinsinden belirtiniz. Örnek: 1024,2048,4096 vb."
                read -p "Belirlenen kapasite : " kapasite
                  if ["$mem" -gt "$kapasite"]; then #BÜYÜKTÜR
                    echo "Onaylandı"
                    islem="1"
                  elif ["$mem" -lt "$kapasite"]; then #küçüktür
                    echo "Onaylanmadı"
                    islem="2"
                   fi
                    case "$islem" in
                      1)
                           echo "Onaylandı" # kişi tarafından tanımlanan miktar tanımlanacaktır.
                           sudo mkdir /mnt/ramdisk
                           sudo chmod 777 /ramdisk
                           sudo mount -t tmpfs -o rw,size=$kapasite+m tmpfs /mnt/ramdisk
                           sudo cp /etc/fstab /etc/fstab.backup.`date +%Y.%m.%d.%H.%M.%S`
                           echo -e "tmpfs  /mnt/ramdisk  tmpfs  rw,size=1024m  0   0" >> /etc/fstab
                           if grep -d /etc/my.cnf; then
                           cp /etc/my.cnf /etc/my.cnf.backup.`date +%Y.%m.%d.%H.%M.%S`
                           echo "tmpdir=/mnt/ramdisk" >> /etc/my.cnf
                           systemctl restart mysqld
                           fi
                           ;;
                      2)
                           echo "Onaylanmadı"; # yazılan ram miktarı toplam kapasiten büyük TEKRAR GİR.
                           echo "Tanımladığınız alan toplam ram kapasitenizi aşmaktadır. Lütfen tekrar deneyin."
                           ;;
                      *)
                           echo "Hatalı işlem"; # Hatalı işlem TEKRAR GİR.
                           echo "Lütfen tekrar deneyin."
                           ;;
                   esac
                elif [ "$onay" == "n" ]; then #ram OTOMASYON tarafından tanımlandı
                  echo "Sistem tarafından ramdisk kapasitesi tanımlanıyor..."
                  echo "Standart tanımlanan ramdisk kapasitesi 1GB"
                  sudo mkdir /mnt/ramdisk
                  sudo chmod 777 /mnt/ramdisk
                  sudo mount -t tmpfs -o rw,size=1024m tmpfs /mnt/ramdisk
                  sudo cp /etc/fstab /etc/fstab.backup.`date +%Y.%m.%d.%H.%M.%S`
                  echo -e "tmpfs  /mnt/ramdisk  tmpfs  rw,size=1024m  0   0" >> /etc/fstab
                  filemycnf="/etc/my.cnf"
                    if [ -f "$filemycnf" ]; then
                  cp /etc/my.cnf /etc/my.cnf.backup.`date +%Y.%m.%d.%H.%M.%S`
                  echo "tmpdir=/mnt/ramdisk" >> /etc/my.cnf
                  systemctl restart mysqld
                  fi
                fi
                fi
               ;;
            3) clear
               main_menu
                ;;
            *)  clear
                echo "Hatalı İşlem girdisi girdiniz. Lütfen tekrar deneyin."
                echo
                ;;
        esac
    done
}

main_menu

exit 0
