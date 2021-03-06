! 
! This file contains functions to output data.  
! plot_data_2d output a 2D slice in the direction perpendicular to "dir" and at a half the height of "dir".

!
! Created by G.P. Brandino, I. Girotto, R. Gebauer
! Last revision: March 2016
!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
subroutine plot_data_2d(filename,n1, n2, n3, idir, data)
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  implicit none

  integer, intent(in) :: n1, n2, n3, idir
  real(8), intent(in) :: data(0:n1-1,0:n2-1,0:n3-1)
  character(len=*), intent(in) :: filename

  character(len=100) :: fnme
  character(len=4) :: fnbr
  integer :: fnumber
  logical :: exst

  integer :: i1,i2,i3

  fnumber = 1
  file_loop: do
     write(fnbr,'(i4.4)') fnumber
     fnme = trim(filename)//trim(fnbr)//".dat"
     inquire(file=fnme, exist=exst)
     if(.not.exst) exit file_loop
     fnumber = fnumber+1
     if(fnumber.ge.10000) call errore('plot_data_2d','no free filename found',fnumber)
  enddo file_loop

  open(unit=11,file=fnme, status='new')
  !
  ! HINT: Assuming you sliced your system along i3, iif idir.eq.1 or idir.eq.2 you 
  !       need to take the correct slice of the plane from each process. If idir.eq.3, you need  
  !       to understand which process holds the plane you are inrested in. 
  !
  if(idir.eq.1) then
     i1=n1/2-1
     do i2=0,n2-1
        do i3=0,n3-1
           write(11,fmt='(f14.6,"  ")',advance='no') data(i1,i2,i3)
        enddo
        write(11,*)
     enddo
  else if(idir.eq.2) then
     i2=n2/2-1
     do i1=0,n1-1
        do i3=0,n3-1
           write(11,fmt='(f14.6,"  ")',advance='no') data(i1,i2,i3)
        enddo
        write(11,*)
     enddo
  else if(idir.eq.3) then
     i3=n3/2-1
     do i1=0,n1-1
        do i2=0,n2-1
           write(11,fmt='(f14.6,"  ")',advance='no') data(i1,i2,i3)
        enddo
        write(11,*)
     enddo
  else
     call errore('plot_data_2d','wrong value for idir',1)
  endif

  close(11)
  
  
end subroutine plot_data_2d
