component Main {
  connect Application exposing { page }

  style base {
    font-family: sans;
    font-weight: bold;
    font-size: 50px;

    justify-content: center;
    align-items: center;
    display: flex;
    height: 100vh;
    width: 100vw;
  }

  get content : Html {
    case (page) {
      Page::Edit => <UserForm isNew={false}/>
      Page::New => <UserForm isNew={true}/>
      Page::Index => <Users.Table/>
      Page::NotFound => <div/>
    }
  }

  fun render : Html {
    <Users.Layout>
      <{ content }>
    </Users.Layout>
  }
}
