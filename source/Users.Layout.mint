component Users.Layout {
  property children : Array(Html) = []

  style wrapper {
    max-width: 1040px;
    padding: 0 20px;
    margin: 0 auto;
  }

  style content {
    padding: 24px 0;
  }

  fun render : html {
    <div>
      <Ui.Breadcrumbs separator="|">
        <Ui.Breadcrumb
          label="Home"
          href="/"/>

        <Ui.Breadcrumb
          label="New User"
          href="/new"/>
      </Ui.Breadcrumbs>

      <div::wrapper>
        <div::content>
          <{ children }>
        </div>
      </div>
    </div>
  }
}
