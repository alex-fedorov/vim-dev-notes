
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

fu! dev_notes#summary()
  call system('echo "" > .dev_notes/.summary')
  exe ':e! .dev_notes_summary.md'

  for file in split(system('find .dev_notes -type f -size +1c'), "\n")
    let info = matchlist(file, '^\.dev_notes\/\(.*\)\/L\(\d\+\)\.md$')
    let path = info[1]
    let line = info[2]

    let start_line = max([1, line - 4])
    let end_line = start_line + 10

    let header = path . ':L' . line . ':'
    let text = system('cat ' . file)
    let code = system("sed -n '" . start_line . ',' . end_line . "p' " . path)

    let content = "\n`" . header . "`\n\n```\n" . code . "\n```\n\n" . text . "\n\n"

    call append(line('$'), split(content, "\n"))
  endfor

  exe ':w!'
endfu

com! Notes call dev_notes#summary()

