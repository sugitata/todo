<todo>

  <h1>Todo list</h1>

  <ul>
    <li each={ items } class="task">
      <label class={ completed: done }>
        <input type="checkbox" checked={ done } onclick={ parent.toggle }> { title }<span>{ date }<span>
      </label>
      <button id="editButton1" onclick={ parent.tagEdit }>タグ編集</button>
      <button id="editButton2" onclick={ parent.childEdit }>タスク編集</button>
      <div hide={ true } class="edit_tag">
          <form onsubmit={ addTag }>
            <input name="tagInput" size="30px" onkeyup={ edit }>
            <button disabled={ !text }>Add</button>
            <button onclick={ parent.finTagEdit }>終了</button>
          </form>
      </div>

      <ul>
        <li each={ tagContents }>
            { tagName }
            <button onclick={ parent.removeTag(tagContents) }>X</button>
        </li>
      </ul>

      <div class="edit_child" hide={ true }>
          <form onsubmit={ addChild }>
            <input name="childInput" size="48px" onkeyup={ edit }>
            <input name="childTime" id="childTime" type="time" onchange={ editTime }>
            <button disabled={ !text || !time }>Add</button>
            <button disabled={ e.item.children.filter(onlyDone).length == 0 } onclick={ removeChildrenDone }>Done</button>
            <button onclick={ parent.finChildEdit }>終了</button>
          </form>
      </div>

      <ul id="childList">
        <li each={ children } class="child">
         <label class={ completed: done }>
          <input type="checkbox" checked={ done } onclick={ parent.toggle }> { title }<span class="clearfix">{ time }</span>
         </label>
        </li>
      </ul>

    </li>
  </ul>
  <form onsubmit={ add }>

    <input name="input" size="50px" onkeyup={ edit }>
    <input name="dateTime" type="date" onchange={ editDate }>
    <button disabled={ !text || !date }>Add #{ items.filter(whatShow).length + 1 }</button>

    <button disabled={ items.filter(onlyDone).length == 0 } onclick={ removeAllDone }>
    Done { items.filter(onlyDone).length } </button>
  </form>

  <script>
    let self = this
    self.items = JSON.parse(localStorage.getItem("text")) || []

    function save() {
      let fieldValue = JSON.stringify(self.items)
      localStorage.setItem("text", fieldValue)
    }

    self.edit = e => self.text = e.target.value

    self.editDate = e => self.date = e.target.value

    self.editTime = e => self.time = e.target.value

    self.tagEdit = e => $(e.target).siblings('.edit_tag').slideDown()

    self.finTagEdit = e => $(e.target).parent().parent().slideUp()

    self.childEdit = e => $(e.target).siblings('.edit_child').slideDown()

    self.finChildEdit = e => $(e.target).parent().parent().slideUp()

    add(e) {
      if (self.text) {
        self.items.push({ title: self.text, date: self.date, tagContents: [], children: [] })
        save()

        e.target[0].value = ''
        e.target[1].value = ''
        self.text = ''
        self.date = ''
      }
    }

    addTag(e) {
      if (self.text) {
        e.item.tagContents.push({ tagName: self.text })
        save()

        e.target[0].value = ''
        self.text = ''
      }
    }

    addChild(e) {
      if (self.text) {
        e.item.children.push({ title: self.text, time: self.time })
        save()

        e.target[0].value = ''
        e.target[1].value = ''
        self.text = ''
        self.time = ''
      }
    }

    removeAllDone(e) {
      self.items = self.items.filter(item => !item.done)
      save()
    }

    removeChildrenDone(e) {
      e.item.children = e.item.children.filter(child => !child.done)
      save()
    }


    removeTag(tagContents) {
      return e => {
        let index = tagContents.indexOf(e.item)
        tagContents.splice(index, 1)
        save()
      }
    }

    self.onlyDone = item => item.done

    self.toggle = e => e.item.done = !e.item.done

  </script>
</todo>
