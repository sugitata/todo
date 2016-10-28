<todo>

  <h1>Todo list</h1>

  <ul>
    <li each={ items } class="task">
      <label class={ completed: done }>
        <input type="checkbox" checked={ done } onclick={ parent.toggle }> { title }<span>{ date }<span>
      </label>
      <button id="editButton1" onclick={ parent.tagEdit }>タグ編集</button>
      <button id="editButton2" onclick={ parent.childEdit }>タスク編集</button>
      <div hide={ visible } class="edit_tag">
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

      <div class="edit_child" hide={ visible }>
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
          <input type="checkbox" checked={ done } onclick={ parent.toggleChild }> { title }<span class="clearfix">{ time }</span>
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

    this.visible = true

    function saveItem(contents) {
      var fieldValue = JSON.stringify(contents)
      localStorage.setItem("text", fieldValue)
    }

    var newItem = JSON.parse(localStorage.getItem("text"))

    if(newItem) {
      this.items = newItem
    } else {
      this.items = []
    }

    edit(e) {
      this.text = e.target.value
    }

    editDate(e) {
      this.date = e.target.value
    }

    editTime(e) {
      this.time = e.target.value
    }


    tagEdit(e) {
      var num = this.items.indexOf(e.item)
      $('.edit_tag').eq(num).slideDown()
    }

    finTagEdit(e) {
      var num = this.items.indexOf(e.item)
      $('.edit_tag').eq(num).slideUp()
    }

    childEdit(e) {
      var num = this.items.indexOf(e.item)
      $('.edit_child').eq(num).slideDown()
    }

    finChildEdit(e) {
      var num = this.items.indexOf(e.item)
      $('.edit_child').eq(num).slideUp()
    }

    add(e) {
      if (this.text) {
        this.items.push({ title: this.text, date: this.date, tagContents: [], children: [] })

        saveItem(this.items)

        this.input.value = ""
        this.text = this.input.value
        this.dateTime.value = ""
        this.date = this.dateTime.value
      }
    }

    addTag(e) {
      if (this.text) {
        e.item.tagContents.push({ tagName: this.text })

        saveItem(this.items)

        var num = this.items.indexOf(e.item)
        this.tagInput[num].value = ""
        this.text = this.tagInput[num].value
      }
    }

    addChild(e) {
      if (this.text) {
        e.item.children.push({ title: this.text, time: this.time })

        saveItem(this.items)

        var num = this.items.indexOf(e.item)
        this.childInput[num].value = ""
        this.text = this.childInput[num].value
        this.childTime[num].value = ""
        this.time = this.childTime[num].value
      }
    }

    removeAllDone(e) {
      this.items = this.items.filter(function(item) {
        return !item.done
      })

      if(!this.item){
        this.childInput = []
        this.childTime = []
        this.tagInput = []
      }

      var fieldValue = JSON.stringify(this.items)
      localStorage.setItem("text", fieldValue)
    }

    removeChildrenDone(e) {
      e.item.children = e.item.children.filter(function(child) {
        return !child.done
      })

      var fieldValue = JSON.stringify(this.items)
      localStorage.setItem("text", fieldValue)
    }


    removeTag(tagContents) {
      return function(e){
          var tagcontent = e.item
          var index = tagContents.indexOf(tagcontent)
          this.tagContents.splice(index, 1)

          var fieldValue = JSON.stringify(this.items)
          localStorage.setItem("text", fieldValue)
      }
    }


    onlyDone(item) {
      return item.done
    }

    toggle(e) {
      var item = e.item
      item.done = !item.done
    }

    toggleChild(e) {
      var child = e.item
      child.done = !child.done
    }

  </script>

</todo>