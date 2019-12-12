!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!			arTeMiDe 2.02
!
!	The module that contains support functions for input-output used within artemide
!
!				A.Vladimirov (08.09.2019)
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

module IO_functions

  implicit none
  
  !!!! colors for colring of the ansi-output
  character(len=1), parameter :: c_esc = achar(27)
  character(len=2), parameter :: c_start = c_esc // '['
  character(len=1), parameter :: c_end = 'm'
  character(len=*), parameter :: c_black = '30'
  character(len=*), parameter :: c_black_bold = '30;1'
  character(len=*), parameter :: c_red = '31'
  character(len=*), parameter :: c_red_bold = '31;1'
  character(len=*), parameter :: c_green = '32'
  character(len=*), parameter :: c_green_bold = '32;1'
  character(len=*), parameter :: c_yellow = '33'
  character(len=*), parameter :: c_blue = '34'
  character(len=*), parameter :: c_magenta = '35'
  character(len=*), parameter :: c_cyan = '36'
  character(len=*), parameter :: c_white = '37'
  character(len=*), parameter :: c_clear = c_start // '0' // c_end
  
contains
  
  !!!the function that makes string-ansi-colored
  !!!initial code copied from http://fortranwiki.org/fortran/show/ansi_colors
  function color(str, code) result(out)
    character(len=*), intent(in) :: str
    character(len=*), intent(in) :: code
    character(len=:), allocatable :: out
    out = c_start // code // c_end // str // c_clear
  end function color
  
  !!! move the CURRET in streem to the next line that starts from pos (5 char)
  !!! this function is universally used in all reading of constants-files
  subroutine MoveTO(streem,pos)
    integer,intent(in)::streem
    character(len=5)::pos
    character(len=300)::line
    do
      read(streem,'(A)') line    
      if(line(1:5)==pos) exit
    end do
 end subroutine MoveTO
 
 !!! write list of short integers (I5) to streem spliting by commas
 !!! used to fill constants-file
 subroutine writeShortIntegerList(streem, list)
 integer::streem,i
 integer,intent(in)::list(:)
    do i=1,size(list)-1
      write(streem,"(I5,', ')",advance='no') list(i)
    end do
    write(streem,"(I5)") list(size(list))
 end subroutine writeShortIntegerList
 
  !!!Common format of Warning line in artemide
  function WarningString(str, moduleName) result(out)
    character(len=*), intent(in) :: str
    character(len=*), intent(in) :: moduleName
    character(len=:), allocatable :: out
    out = color('WARNING: artemide.'//trim(moduleName)//': '//trim(str),c_red)
  end function WarningString
  
  !!!Common format of error line in artemide
  function ErrorString(str, moduleName) result(out)
    character(len=*), intent(in) :: str
    character(len=*), intent(in) :: moduleName
    character(len=:), allocatable :: out
    out = color('ERROR: artemide.'//trim(moduleName)//': '//trim(str),c_red_bold)
  end function ErrorString

end module IO_functions