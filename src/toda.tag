<todo>

  <h1>{ opts.title }</h1>

  <ul>
    <li each={ items.filter(whatShow) }>
      <label class={ completed: done }>
        <input type="checkbox" class="cb" checked={ done } onclick={ parent.toggle }> { title }<span>{ time }<span>
      </label>


      <ul>
        <button onclick={ tagEdit }>タグ編集</button>
        <li each={ taglists }>
            { tagname }
            <button onclick={ parent.removetag }>X</button>
        </li>
        <div hide={ visible } class="edit_tag">
          <form onsubmit={ addTag }>
            <input name="taginput" onkeyup={ editTag }>
            <button>タグ追加</button>
          </form>
        </div>
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

    this.items = newitems

    this.taglists = opts.taglists

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
    // this.origin = false;
    tagEdit(e) {
      this.visible = !this.visible
      // this.origin = !this.origin
    }

    add(e) {
      if (this.text) {
        this.items.push({ title: this.text, time: this.date })
        // title time nestされたtaglistsも全て格納される
        var fieldvalue = JSON.stringify(this.items);
        localStorage.setItem("text", fieldvalue);

        // input,datetimeの名前のついたテキストボックスを空にする役割
        this.text = this.input.value = ""
        this.date = this.datetime.value = ""
      }
    }

    addTag(e) {
      if (this.text) {
        this.taglists.push({ tagname: this.text })
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
      // ループ要素を定義する
      var taglist = event.taglist
      // this.taglistsの配列の、上で定義したe.taglistが何番目にあるのかを調べてindexに格納する
      var index = this.taglists.indexOf(taglist)
      // this.taglistsの配列のindexの番号にある配列要素を1つ取り除く
      this.taglists.splice(index, 1)
    }


    whatShow(item) {
      // filterでitemにおいてhiddenされてるもの以外を表示される
      return !item.hidden
    }

    // tagShow(tag) {
    //   return !tag.hidden
    // }

    onlyDone(item) {
      return item.done
    }

    toggle(e) {
      // 配列要素のitem定義
      var item = e.item
      item.done = !item.done
      return true
    }

    console.log(localStorage.length);
  </script>

</todo>


<!-- ロジックを一回頭の中で組み立ててからやったほうがいいかも -->

<!-- [
{"title":"hello riot","time":"2016-10-13","taglists":[{"tagname":"first"},{"tagname":"second"},{"tagname":"third"}]},

{"title":"Hidden item","hidden":true},
{"title":"hello sass","time":"2016-10-14"},
{"title":"hello gulp","time":"2016-10-14"},
{"title":"hello hoge","time":"2016-10-15"},
{"title":"hello hogehogee","time":"2016-10-17"},
{"title":"fdsafa"}]
 -->



