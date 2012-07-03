<div id="colophon">
    <div class="inner">
        <div class="container">
            <div class="row">
                <div class="span4"><h3><span class="color">::</span> Explore</h3>
                    <ul class="shortcut clearfix">
                        { foreach from=$menu_items item=item}
                        <li><a href="{$url.base}/{$item}">{$item|replace:'-':' '|ucwords}</a></li>
                        {if $item@index % (round(count($menu_items)/2))}
                        </ul>
                        <ul class="shortcut clearfix">
                        {/if}
                        { /foreach}
                    </ul>
                </div>

                <div class="span4"><h3><span class="color">::</span> Contribute!</h3>

                    <p>Do you use the framework? Fork it and suggest us improvements. Or maybe you are starter,
                    you can also help improving the documentation. If you want to help get in touch!</p>
                    <ul class="social-icons-container">
                        <li><a href="javascript:;" class="social-icon social-icon-twitter"> Twitter </a></li>
                        <li><a href="javascript:;" class="social-icon social-icon-googleplus"> Google + </a></li>
                        <li><a href="javascript:;" class="social-icon social-icon-facebook"> Facebook </a></li>
                    </ul>
                </div>
                <div class="span4"><h3><span class="color">::</span> Subscribe and get updates</h3>

                    <p>Subscribe to our newsletter and get exclusive deals you wont find anywhere else straight to your
                        inbox!</p>

                    <form><input type="text" name="subscribe_email" placeholder="Your Email"> <br>
                        <button class="btn ">Subscribe</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="footer_notes">
    <div class="inner">
        <div class="container">
            <p class="right"><a href="#">Back to top</a></p>

            <p>
                SIFO is licensed under the <a href="http://www.apache.org/licenses/LICENSE-2.0" target="_blank">Apache
                License v2.0</a>. Download the source code of this site at <a
                    href="https://github.com/alombarte/sifo-web"
                    target="_blank">GitHub</a>
                <br/>
                <small>In loving memory of <a href="{$url.base}/in-loving-memory" title="In memory of Carlos Soriano">Carlos
                    Soriano</a>.
                </small>
            </p>
        </div>
    </div>
</div>