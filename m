From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH AUTOSEL 5.4 075/130] net/lapb: fix t1 timer handling for LAPB_STATE_0
Date: Thu, 24 Dec 2020 01:49:47 -0800
Message-ID: <CAJht_EOXf4Z3G-rq92hb_YvJEsHtDy15FE7WuthqDQsPY039QQ@mail.gmail.com>
References: <20201223021813.2791612-75-sashal@kernel.org> <20201223170124.5963-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pR2ACc6d8aTjF9n2K3igB+WCeCgG4pxrdUZ6N6y3XI8=;
        b=F0hRaYSIk4MzxylL/ODRdzxdbcBJG2XTEKKFPPjS/e6+wv80GeoxPfKfzYneDuCNCC
         CHiQngXEUCEHaSxZQbe0EvGvKuJBzn4uUQZsOhoNlBfM+EQD+7hcS2TdqDQDPXg7aq24
         IWm8zHFInPmY9dfoaethXfjxzbiY0N/7CjnmYXj+r/riZAy5ljkCgDOPqsUYVMlzWFt9
         qIrGIel3ehiGDT3y8ufUGJCvnvZ5BfpnpjxelSVkfc5Xl1Q968ZWdYclR7PNXWzTMlUP
         ApzZ1jaXDMRwxhwewd2oMVNALF06JfTuUJBrmCYUieUpyd1Pyu36pOE7PYZqJcYpQkcH
         hSjQ==
In-Reply-To: <20201223170124.5963-1-xie.he.0141@gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sasha Levin <sashal@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>

On Wed, Dec 23, 2020 at 9:01 AM Xie He <xie.he.0141@gmail.com> wrote:
>
> I don't think this patch is suitable for stable branches. This patch is
> part of a patch series that changes the lapb module from "establishing the
> L2 connection only when needed by L3", to "establishing the L2 connection
> automatically whenever we are able to". This is a behavioral change. It
> should be seen as a new feature. It is not a bug fix.

Applying this patch without other patches in the same series will also
introduce problems, because this patch relies on part of the changes
in the subsequent patch in the same series to be correct.

Hi Martin,

It's better that we avoid using words like "fix" in non-bug-fix
patches, and make every patch work on its own without subsequent
patches. Otherwise we'll make people confused.
