<todo>

  <h1>{ opts.title }</h1>

<!-- アイテム名とチェックボックス -->

  <ul>
    <li each={ items.filter(whatShow) }>
      <label class={ completed: done }>
        <input type="checkbox" class="cb" checked={ done } onclick={ parent.toggle }> { title }<span>{ time }<span>
      </label>
    </li>
  </ul>

<!-- タスクを追加するフォーム -->
  <form onsubmit={ add }>
    <input name="input" size="50px" onkeyup={ edit }>
    <input name="datetime" type="date" onchange={ edittime }>
    <button disabled={ !text }>Add #{ items.filter(whatShow).length + 1 }</button>

    <button disabled={ items.filter(onlyDone).length == 0 } onclick={ removeAllDone }>
    Done { items.filter(onlyDone).length } </button>
  </form>

  <script>

    this.items = opts.items

    edit(e) {
      this.text = e.target.value
    }

    edittime(e) {
      this.date = e.target.value
    }

    add(e) {
      if (this.text) {
        this.items.push({ title: this.text, time: this.date })
        this.text = this.input.value = ""
        this.date = this.datetime.value = ""
      }
    }

    removeAllDone(e) {
      this.items = this.items.filter(function(item) {
        return !item.done
      })
    }


    whatShow(item) {
      return !item.hidden
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

<!-- タスクの入れ子関係を実現できるように -->
<!-- これはtaskごとにネストを作ってそこにまたtodoアプリの仕組みでフォーム作ってやればいいだけ -->

<!-- ローカルにデータを保存する
これはローカルストレージの利用 -->



<!-- タスクの入れ子関係を実現できるように
これもタグ機能と一緒

親タスク ( >> タグ )　>> 子タスク ( >> タグ ) -->
