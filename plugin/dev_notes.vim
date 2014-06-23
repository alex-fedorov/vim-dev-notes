
fu! dev_notes#note()
  let current_line = line('.')
  let current_path = @%
  let note_folder = '.dev_notes/' . current_path . '/'
  let note_path = '.dev_notes/' . current_path . '/L' . current_line . '.md'

  cal system('mkdir -p ' . note_folder)

  if v:shell_error
    echo 'Error creating dev note folder: ' . note_folder
    return
  endif

  exe ':sp ' . note_path
endfu
com! Note call dev_notes#note()

