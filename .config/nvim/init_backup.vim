require('onedark').setup{
  style = 'darker',
  colors = {
    bg0='#041828',
    purple='#C587C0',
    cyan='#50C9B0',
    fg='#9DDBFE',
    orange='#CD9279',
    green='#6A9957'
  },
  highlights = {
    ["@function"]={fg='#DBDBAA'},
    ["@type.builtin"]={fg='$blue'},
    ["@type"]={fg='$cyan'},
    ["@parameter"]={fg='$fg'},
    ["@string"]={fg='$orange'},
    ["@comment"]={fg='$green'},
      }
}
require ('onedark').load()


