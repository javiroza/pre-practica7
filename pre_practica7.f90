! ---------------------------------- Pre-pràctica 7 ------------------------------------- !
! Autor: Javier Rozalén Sarmiento
! Grup: B1B
! Data: 26/11/2019
!
! Funcionalitat: es programen i es posen a prova els mètodes d'Euler i Euler millorat per a  
! la resolució d'equacions diferencials ordinàries
!
! Comentaris: Les variables que tinguin per nom "theta_" corresponen a l'angle que forma el
! pèndol amb la vertical, mentre que les variables "w_" són les derivades temporals de les 
! "theta_"

program pre_practica7
    implicit none
    double precision m,g,l,pi,t0,tN,theta_0,w_0
    double precision fun1,fun2
    integer N,arxiu
    external fun1,fun2
    common/cts/m,g,l
    
    m=0.510d0 ! Massa del pèndol
    g=8.87d0 ! Gravetat (Venus)
    l=0.45d0 ! Longitud del pèndol
    pi=dacos(-1.d0)
    t0=0.d0
    tN=2.d0*pi/dsqrt(g/l)
    arxiu=11

    open(11,file="P7-1920-res.dat")
    write(11,*) "#Temps, Angle, Velocitat angular, Energia cinètica, Energia potencial, Energia mecànica"

    ! -------------------------------- Apartat a) --------------------------------------- !
    theta_0=pi-0.02d0
    w_0=0.d0
    N=1800
    call euler(theta_0,w_0,t0,5.d0*tN,N,fun1,arxiu) ! index 0 (gnuplot)
    call write(arxiu)
    call eulerm(theta_0,w_0,t0,5.d0*tN,N,fun1,arxiu) ! index 1 (gnuplot)

    ! -------------------------------- Apartat b) --------------------------------------- !
    theta_0=0.04d0
    w_0=0.d0
    N=1300
    call write(arxiu)
    call euler(theta_0,w_0,t0,5.d0*tN,N,fun2,arxiu) ! index 2 (gnuplot)
    call write(arxiu)
    call eulerm(theta_0,w_0,t0,5.d0*tN,N,fun2,arxiu) ! index 3 (gnuplot)

    ! -------------------------------- Apartat c) --------------------------------------- !
    w_0=0.d0
    N=2500

    ! Condició 1
    theta_0=1.d0
    call write(arxiu)
    call euler(theta_0,w_0,t0,5.d0*tN,N,fun1,arxiu) ! index 4 (gnuplot)
    call write(arxiu)
    call eulerm(theta_0,w_0,t0,5.d0*tN,N,fun1,arxiu) ! index 5 (gnuplot)

    ! Condició 2
    theta_0=pi-0.02d0
    call write(arxiu)
    call euler(theta_0,w_0,t0,5.d0*tN,N,fun1,arxiu) ! index 6 (gnuplot)   
    call write(arxiu)
    call eulerm(theta_0,w_0,t0,5.d0*tN,N,fun1,arxiu) ! index 7 (gnuplot) 

    ! -------------------------------- Apartat d) --------------------------------------- !
    theta_0=0.d0
    N=2100

    ! Condició 1
    w_0=2.d0*dsqrt(g/l)+0.03d0
    call write(arxiu)
    call eulerm(theta_0,w_0,t0,11.d0*tN,N,fun1,arxiu) ! index 8 (gnuplot)     

    ! Condició 2
    w_0=2.d0*dsqrt(g/l)-0.03d0
    call write(arxiu)
    call eulerm(theta_0,w_0,t0,11.d0*tN,N,fun1,arxiu) ! index 9 (gnuplot) 

    ! -------------------------------- Apartat e) --------------------------------------- !
    theta_0=2.8d0
    w_0=0.d0

    ! N=600
    N=600
    call write(arxiu)
    call eulerm(theta_0,w_0,t0,12.d0*tN,N,fun1,arxiu) ! index 10 (gnuplot)

    ! N=1300
    N=1300
    call write(arxiu)
    call eulerm(theta_0,w_0,t0,12.d0*tN,N,fun1,arxiu) ! index 11 (gnuplot)

    ! N=2600
    N=2600
    call write(arxiu)
    call eulerm(theta_0,w_0,t0,12.d0*tN,N,fun1,arxiu) ! index 12 (gnuplot)

    ! N=15000
    N=15000
    call write(arxiu)
    call eulerm(theta_0,w_0,t0,12.d0*tN,N,fun1,arxiu) ! index 13 (gnuplot)    


    close(11)
end program pre_practica7

! Subrutina euler --> Escriu en un arxiu l'evolució temporal del pèndol simple calculada 
! amb el mètode d'Euler
subroutine euler(theta_0,w_0,t0,tN,N,funcio,arxiu)
    implicit none
    double precision theta_n1,theta_n,w_n1,w_n,theta_0,w_0,t0,tN,h,funcio
    double precision Ecine,Epoten,Etotal
    double precision m,g,l
    integer arxiu,i,N
    common/cts/m,g,l

    h=(tN-t0)/dble(N) ! Pas 
    theta_n=theta_0
    w_n=w_0

    write(arxiu,*) t0,theta_n,w_n

    ! Amb els primers valors calculats amb les condicions inicials, iniciem el bucle
    do i=1,N-1 ! Ja hem escrit un valor (sense comptar les cond. inicials)
        ! Noves variables theta_n1,w_n1
        theta_n1=theta_n+h*w_n
        w_n1=w_n+h*funcio(theta_n)
        ! Escrivim a l'arxiu les noves variables
        write(arxiu,*) t0+(i+1)*h,theta_n1,w_n1,Ecine(w_n1),Epoten(theta_n1),Etotal(theta_n1,w_n1)
        ! Sobreescrivim variables
        theta_n=theta_n1
        w_n=w_n1
    enddo

    return
end subroutine euler

! Subrutina eulerm --> Escriu en un arxiu l'evolució temporal del pèndol simple calculada 
! amb el mètode d'Euler millorat
subroutine eulerm(theta_0,w_0,t0,tN,N,funcio,arxiu)
    implicit none
    double precision theta_n1,theta_n,theta_n_1,w_n1,w_n,w_n_1,theta_0,w_0,t0,tN,h,funcio
    double precision Ecine,Epoten,Etotal
    double precision m,g,l
    integer arxiu,i,N
    common/cts/m,g,l

    h=(tN-t0)/dble(N) ! Pas 
    theta_n_1=theta_0
    w_n_1=w_0

    ! Calculem theta_1 i w_1 amb w_0,theta_0 i l'algorisme d'Euler
    theta_n=theta_n_1+h*w_n_1
    w_n=w_n_1+h*funcio(theta_n_1)

    ! Escrivim els valors calculats fins ara
    write(arxiu,*) t0,theta_n_1,w_n_1
    write(arxiu,*) t0+h,theta_n,w_n

    ! Amb els primers valors calculats amb les condicions inicials, iniciem el bucle
    do i=1,N-1 ! Ja hem escrit 2 valors (sense comptar les cond. inicials)
        ! Noves variables theta_n1,w_n1
        theta_n1=theta_n_1+2.d0*h*w_n
        w_n1=w_n_1+2.d0*h*funcio(theta_n)
        ! Escrivim a l'arxiu les noves variables
        write(arxiu,*) t0+(i+2)*h,theta_n1,w_n1,Ecine(w_n1),Epoten(theta_n1),Etotal(theta_n1,w_n1)
        ! Sobreescrivim variables
        theta_n_1=theta_n
        w_n_1=w_n
        theta_n=theta_n1
        w_n=w_n1
    enddo

    return
end subroutine eulerm

! Subrutina write --> Escriu dues línies en blanc en un arxiu
subroutine write(arxiu)
    implicit none
    integer arxiu
    write(arxiu,*) ""
    write(arxiu,*) ""
    return
end subroutine

! Funció Ecine --> Energia cinètica del pèndol en funció de w
double precision function Ecine(w)
    implicit none
    double precision w
    double precision m,g,l
    common/cts/m,g,l
    Ecine=0.5d0*m*(w*l)**2.d0
    return
end function Ecine

! Funció Epoten --> Energia potencial del pèndol en funció de theta
double precision function Epoten(theta)
    implicit none
    double precision theta
    double precision m,g,l
    common/cts/m,g,l
    Epoten=-m*g*l*dcos(theta)
    return
end function Epoten

! Funció Etotal --> Energia total del pèndol (constant del moviment)
double precision function Etotal(theta,w)
    implicit none
    double precision theta,w,Epoten,Ecine
    Etotal=Epoten(theta)+Ecine(w)
    return
end function Etotal

! Funció fun1 --> funció auxiliar 1
double precision function fun1(theta)
    implicit none
    double precision theta
    double precision m,g,l
    common/cts/m,g,l
    fun1=-(g/l)*dsin(theta)
    return
end function fun1

! Funció fun2 --> funció auxiliar 2
double precision function fun2(theta)
    implicit none
    double precision theta
    double precision m,g,l
    common/cts/m,g,l
    fun2=-(g/l)*theta
    return
end function fun2