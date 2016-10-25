<todo>

  <h1>{ opts.title }</h1>

  <ul>
    <li each={ items } class="task">
      <label class={ completed: done }>
        <input type="checkbox" class="cb" checked={ done } onclick={ parent.toggle }> { title }<span>{ time }<span>
      </label>
      <button onclick={ parent.tagEdit }>タグ編集</button>
      <button onclick={ parent.childEdit }>タスク編集</button>
      <div hide={ visible } class="edit_tag">
          <form onsubmit={ addTag }>
            <input name="taginput" size="30px" onkeyup={ editTag }>
            <button disabled={ !text }>Add</button>
            <button onclick={ parent.finEdit }>終了</button>
          </form>
      </div>


      <ul>
        <li each={ tagContents }>
            { tagName }
            <button onclick={ parent.removeTag(tagContents) }>X</button>
        </li>
      </ul>

      <div hide={ visible } class="edit_child">
          <form onsubmit={ addChild }>
            <input name="childinput" size="48px" onkeyup={ editChild }>
            <input name="childtime" type="time" onchange={ editClock }>
            <button disabled={ !text }>Add</button>
            <button disabled={ e.item.children.filter(onlyDone).length == 0 } onclick={ removeChildrenDone(children) }>Done</button>
            <button onclick={ parent.finEditChild }>終了</button>
          </form>
      </div>

      <ul if={ children }>
        <li each={ children } class="child">
         <label class={ completed: done }>
          <input type="checkbox" checked={ done } onclick={ parent.toggleChild(children) }> { title }<span class="clearfix">{ clock }</span>
         </label>
        </li>
      </ul>

    </li>
  </ul>
  <form onsubmit={ add }>

    <input name="input" size="50px" onkeyup={ edit }>
    <input name="datetime" type="date" onchange={ editTime }>
    <button disabled={ !text }>Add #{ items.filter(whatShow).length + 1 }</button>

    <button disabled={ items.filter(onlyDone).length == 0 } onclick={ removeAllDone }>
    Done { items.filter(onlyDone).length } </button>
  </form>

  <script>
    var newItem = JSON.parse(localStorage.getItem("text"));

    if(newItem) {
      this.items = newItem
    }
    else {
      this.items = [];
    };

    // this.items = opts.items

    edit(e) {
      this.text = e.target.value
    }

    editTime(e) {
      this.date = e.target.value
    }

    editTag(e) {
      this.text = e.target.value
    }

    editChild(e) {
      this.text = e.target.value
    }

    editClock(e) {
      this.time = e.target.value
    }

    this.visible = true;

    tagEdit(e) {
      var num = this.items.indexOf(e.item)
      $('.edit_tag').eq(num).css("display","block");
    }

    finEdit(e) {
      var num = this.items.indexOf(e.item)
      $('.edit_tag').eq(num).css("display","none");
    }

    childEdit(e) {
      var num = this.items.indexOf(e.item)
      $('.edit_child').eq(num).css("display","block");
    }

    finEditChild(e) {
      var num = this.items.indexOf(e.item)
      $('.edit_child').eq(num).css("display","none");
    }

    add(e) {
      if (this.text) {
        this.items.push({ title: this.text, time: this.date })

        var fieldValue = JSON.stringify(this.items);
        localStorage.setItem("text", fieldValue);

        this.text = this.input.value = ""
        this.date = this.datetime.value = ""
      }
    }

    addTag(e) {
      if (!e.item.tagContents){
        e.item.tagContents = [];
      }

      if (this.text) {
        e.item.tagContents.push({ tagName: this.text })

        var fieldValue = JSON.stringify(this.items);
        localStorage.setItem("text", fieldValue);

        this.text = this.taginput.value = ""
      }
    }

    addChild(e) {
      if (!e.item.children){
        e.item.children = [];
      }

      if (this.text) {
        e.item.children.push({ title: this.text, clock: this.time })

        var fieldValue = JSON.stringify(this.items);
        localStorage.setItem("text", fieldValue);

        this.text = this.taginput.value = ""
        this.time = this.taginput.value = ""
      }
    }

    removeAllDone(e) {
      this.items = this.items.filter(function(item) {
        return !item.done
      })

      var fieldValue = JSON.stringify(this.items);
      localStorage.setItem("text", fieldValue);
    }

    // done: trueにしてある配列がreturn !child.doneで消えない
    removeChildrenDone(children) {
      return function(e){
          this.children = this.children.filter(function(child) {
            return !child.done
          })

          var fieldValue = JSON.stringify(this.items);
          localStorage.setItem("text", fieldValue);
        }
    }


    removeTag(tagContents) {
      return function(e){
          var tagcontent = e.item
          var index = tagContents.indexOf(tagcontent)
          this.tagContents.splice(index, 1)

          var fieldValue = JSON.stringify(this.items);
          localStorage.setItem("text", fieldValue);
     }
    }


    onlyDone(item) {
      return item.done
    }

    toggle(e) {
      var item = e.item
      item.done = !item.done
      return true
    }

    toggleChild(children) {
      return function(e){
        var child = e.item
        child.done = !child.done
        return true
      }
    }
  </script>

</todo>

