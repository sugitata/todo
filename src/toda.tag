<todo>

  <h1>{ opts.title }</h1>

  <ul>
    <li each={ items }>
      <label class={ completed: done }>
        <input type="checkbox" class="cb" checked={ done } onclick={ parent.toggle }> { title }<span>{ time }<span>
      </label>
      <button onclick={ parent.tagEdit }>タグ編集</button>
      <div hide={ visible } class="edit_tag">
          <form onsubmit={ parent.addTag }>
            <input name="taginput" onchange={ editTag }>
            <button>タグ追加</button>
            <button onclick={ parent.finEdit }>編集終了</button>
          </form>
      </div>


      <ul>
        <li each={ tagcontents }>
            { tagname }
            <button onclick={ parent.removetag }>X</button>
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
    var newitems = JSON.parse(localStorage.getItem("text"));

    if(newitems) {
      this.items = newitems
    }
    else {
      this.items = [];
    };

    // this.items = opts.items


    this.tagcontents = opts.items.tagcontents

    edit(e) {
      this.text = e.target.value
    }

    editTime(e) {
      this.date = e.target.value
    }

    editTag(e) {
      this.text = e.target.value
    }

    this.visible = true;

    tagEdit(e) {
      var num = this.items.indexOf(e.item)
      console.log(num);
      $('.edit_tag').eq(num).css("display","block");
    }

    finEdit(e) {
      var num = this.items.indexOf(e.item)
      console.log(num);
      $('.edit_tag').eq(num).css("display","none");
    }

    add(e) {
      if (this.text) {
        this.items.push({ title: this.text, time: this.date, tagcontents: [] })

        var fieldvalue = JSON.stringify(this.items);
        localStorage.setItem("text", fieldvalue);

        this.text = this.input.value = ""
        this.date = this.datetime.value = ""
      }
    }

    addTag(e) {
      if (this.text) {
        e.item.tagcontents.push({ tagname: this.text })

        var fieldvalue = JSON.stringify(this.items);
        localStorage.setItem("text", fieldvalue);

        this.text = this.taginput.value = ""
      }
    }

    removeAllDone(e) {
      this.items = this.items.filter(function(item) {
        return !item.done
      })

      var fieldvalue = JSON.stringify(this.items);
      localStorage.setItem("text", fieldvalue);
    }

    removetag(e) {
      // this.tagcontents, e.tagcontentがundefinedになっちゃう
      // console.log(e.item);
      // console.log(e.itme.tagcontents);
      var tagcontent = e.tagcontent
      console.log(tagcontent);
      var index = e.item.tagcontents.indexOf(tagcontent)
      this.tagcontents.splice(index, 1)
    }


    onlyDone(item) {
      return item.done
    }

    toggle(e) {
      var item = e.item
      item.done = !item.done
      return true
    }
  </script>

</todo>





