---
title: Fill Me
hide:
  - title
---


<div class="custom-inline-form" markdown="1">
  <h2 markdown="span">*With Your Eyes* :eyes:</h2>
  <p markdown="span">***You Freak!*** :biting_lip: </p>
  
  <!-- Invisible iframe to capture form submission without redirecting -->
  <iframe name="inline_hidden_iframe" id="inline_hidden_iframe" style="display:none;" onload="if(inlineSubmitted) { showInlineSuccess(); }"></iframe>
  
  <form id="inline-newsletter-form" action="https://docs.google.com/forms/d/e/1FAIpQLSeWLNOTiH9ahyf3Pri8M59E9MZsBLT67Xc_otukd2_bgwxoJw/formResponse" method="post" target="inline_hidden_iframe" onsubmit="inlineSubmitted=true;">

    <input type="text" name="entry.2005620554" placeholder="Your Name" required class="form-input">
    <input type="email" name="emailAddress" placeholder="Your Email..." required class="form-input">
    <input type="address" name="entry.1065046570" placeholder="Your Address..." class="form-input">
    <input type="phone" name="entry.1166974658" placeholder="Your Phone Number..." class="form-input">
    <input type="comment" name="entry.839337160" placeholder="Any Thoughts..." class="form-input">


    <!-- Utilizing native MkDocs-Material button classes -->
    <button type="submit" class="md-button md-button--primary">Sign Me Up</button>
    
  </form>
  
  <div id="inline-success-message" style="display: none; padding-top: 1rem;">
    <h3 style="color: var(--md-primary-fg-color); margin-bottom: 0;">Hell yeah. You're on the list! 🦬</h3>
  </div>
</div>

<script>
  // Variables renamed to avoid collision if the splash modal script is also running on this page
  var inlineSubmitted = false;
  
  function showInlineSuccess() {
    document.getElementById('inline-newsletter-form').style.display = 'none';
    document.getElementById('inline-success-message').style.display = 'block';
  }
</script>

<!-- <iframe src="https://docs.google.com/forms/d/e/1FAIpQLSeWLNOTiH9ahyf3Pri8M59E9MZsBLT67Xc_otukd2_bgwxoJw/viewform?embedded=true" width="640" height="856" frameborder="0" marginheight="0" marginwidth="0">Loading…</iframe> -->