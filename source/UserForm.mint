record UserForm.State {
  saving : Bool
}

component UserForm {
  connect Ui exposing { theme }

  property isNew : Bool = false

  connect Users.List exposing {
    page,
    refresh,
    loading,
    user,
    saveUser,
    setStatus,
    setFirstName,
    setLastName,
    error,
    createUser,
    deleteUser
  }

  state : UserForm.State { saving = false }

  get buttonLabel : String {
    if (state.saving) {
      if (isNew) {
        "Creating"
      } else {
        "Saving"
      }
    } else {
      if (isNew) {
        "Create"
      } else {
        "Save"
      }
    }
  }

  fun create : Void {
    do {
      next { state | saving = true }
      createUser()
      next { state | saving = false }
      Window.navigate("/")
    }
  }

  fun save : Void {
    do {
      next { state | saving = true }
      saveUser()
      refresh()
      next { state | saving = false }
      Window.navigate("/?page=" + Number.toString(page))
    }
  }

  fun handleDelete : Void {
    do {
      deleteUser()
      Window.navigate("/?page=" + Number.toString(page))
    }
  }

  fun onClick (event : Html.Event) : Void {
    if (isNew) {
      create()
    } else {
      save()
    }
  }

  fun onClearFirstName : Void {
    setFirstName("")
  }

  fun onClearLastName : Void {
    setLastName("")
  }

  get disabled : Bool {
    String.isEmpty(user.firstName) || String.isEmpty(user.lastName)
  }

  get title : String {
    if (isNew) {
      "Create User"
    } else {
      "Edit User"
    }
  }

  get deleteField : Array(Html) {
    if (isNew) {
      []
    } else {
      [
        <Ui.Form.Separator/>,
        <Ui.Button
          onClick={\event : Html.Event => handleDelete()}
          type="danger"
          label="Delete"/>
      ]
    }
  }

  style title {
    border-bottom: 2px solid #CCC;
    padding-bottom: 10px;
    margin-bottom: 15px;
    font-weight: bold;
    font-size: 20px;
    opacity: 0.8;
  }

  style form {
    & > * {
      margin-bottom: 15px;
    }
  }

  fun render : Html {
    <Ui.Loader shown={loading}>
      <div key={Number.toString(user.id)}>
        <div::title>
          <{ title }>
        </div>

        <div::form>
          <Ui.Form.Field label="First Name">
            <Ui.Input
              value={user.firstName}
              onInput={setFirstName}
              onClear={onClearFirstName}
              placeholder="John"/>
          </Ui.Form.Field>

          <Ui.Form.Field label="Last Name">
            <Ui.Input
              value={user.lastName}
              onInput={setLastName}
              onClear={onClearLastName}
              placeholder="Doe"/>
          </Ui.Form.Field>

          <Ui.Form.Field label="Status">
            <Ui.Toggle
              checked={user.status == "locked"}
              onChange={setStatus}
              offLabel="Locked"
              onLabel="Active"
              width={150}/>
          </Ui.Form.Field>

          <Ui.Button
            label={buttonLabel}
            onClick={onClick}
            disabled={disabled}/>

          <{ deleteField }>
        </div>
      </div>
    </Ui.Loader>
  }
}
