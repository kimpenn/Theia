ui <-
  navbarPage(
    theme = shinytheme("paper"),
    title = "Theia",
    tabPanel("Upload File", uploadFileUI("uploadFile")),
    tabPanel("Quality Control", qualityControlUI("qualityControl")),
    tabPanel("Exp Info", expInfoUI("expInfo")),
    tabPanel("STAR", starUI("star")),
    tabPanel("VERSE", verseUI("verse")),
    tabPanel("BLAST", blastUI("blast")),
    tabPanel("Trim", trimUI("trim")),
    tabPanel("Misc.", miscUI("misc"))
  )
