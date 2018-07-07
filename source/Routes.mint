store Application {
  property page : Page = Page::Index

  fun setPage (page : Page) : Void {
    next { state | page = page }
  }
}

enum Page {
  NotFound
  Index
  Edit
  New
}

routes {
  /new {
    do {
      Application.setPage(Page::New)
      Users.List.resetUser()
    }
  }

  /:id (id : Number) {
    do {
      Application.setPage(Page::Edit)
      Users.List.resetUser()
      Users.List.getUser(id)
    }
  }

  /?page=:page (page : String) {
    do {
      Application.setPage(Page::Index)
      Users.List.refresh()

      actualPage =
        Number.fromString(page)
        |> Maybe.withDefault(0)

      Users.List.setPage(actualPage)
    }
  }

  / {
    do {
      Application.setPage(Page::Index)
      Users.List.refresh()
      Users.List.setPage(0)
    }
  }

  * {
    Application.setPage(Page::NotFound)
  }
}
