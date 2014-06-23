
fu! dev_notes#note()
  let note_folder = '.dev_notes/' . @% . '/'
  let note_path = note_folder . 'L' . line('.') . '.md'

  call system('mkdir -p ' . note_folder)

  if v:shell_error
    echo 'Error creating dev note folder'
    ret
  endif

  exe ':sp ' . note_path
endfu

fu! dev_notes#toggle_note()
  if @% =~ "^\.dev_notes\/"
    exe ':wq'
  else
    call dev_notes#note()
  endif
endfu

com! Note call dev_notes#toggle_note()

