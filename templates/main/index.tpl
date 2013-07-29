{extends $template}
{block "title" prepend}Sign In{/block}
{block "content"}
<form class="form-signin" action="?controller=main&action=login" method="post">
  <h2 class="form-signin-heading">Please sign in</h2>
  <input type="text" class="form-control" placeholder="Username" autofocus name="username">
  <input type="password" class="form-control" placeholder="Password" name="password">
  <button class="btn btn-large btn-primary btn-block" type="submit">Sign in</button>
</form>
{/block}
