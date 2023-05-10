From: Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH] docs: networking: fix x25-iface.rst heading & index order
Date: Wed, 10 May 2023 15:29:03 +0700
Message-ID: <334e9041-5121-3dc7-9ddd-4ce33585fec6@gmail.com>
References: <20230510022914.2230-1-rdunlap@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683707347; x=1686299347;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z8RwRIsfRADOKmrmxPkNV2fLHwpgOdBlB311q+5skVQ=;
        b=jEOcMdkwiWfkDoBrNqA4na8Gdr2MZN3tgMBfXMcXf010KyfCNmgKjfaOebiEpVClxJ
         ujbM3w3bQhCMdH6HnyPlpireLhs+egi5d1aPTyne0LPbHzbhAIziblvsuCdBpHq7B/j3
         BOK3w+nFqnN4tQXBJbDR6VvFpCRf+wEECIkI0OnkkDBOpzacpqfZA8qkIMawg3nOl+1/
         1txIGxtAxFPKqUOWQSH+GVdTSQRC49wUczjaKcjQHrIcoBJDjrMEFDCtlIj8lhyNSQ1o
         iXh5LBk7b7nvIh5kZICoHkjHIFAY9ApCJhj8yNBkewT/zREhY2lIrSTXeXezTce48sIi
         VJ/g==
Content-Language: en-US
In-Reply-To: <20230510022914.2230-1-rdunlap@infradead.org>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>, linux-x25@vger.kernel.org

On 5/10/23 09:29, Randy Dunlap wrote:
> -============================-
>  X.25 Device Driver Interface
> -============================-
> +============================
>  

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara

