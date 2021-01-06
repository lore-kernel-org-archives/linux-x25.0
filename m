From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH AUTOSEL 5.4 075/130] net/lapb: fix t1 timer handling for
 LAPB_STATE_0
Date: Wed, 06 Jan 2021 08:33:04 +0100
Message-ID: <70be903f2be49e243b5a28cf565c07a8@dev.tdt.de>
References: <20201223021813.2791612-75-sashal@kernel.org>
 <20201223170124.5963-1-xie.he.0141@gmail.com>
 <CAJht_EOXf4Z3G-rq92hb_YvJEsHtDy15FE7WuthqDQsPY039QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <CAJht_EOXf4Z3G-rq92hb_YvJEsHtDy15FE7WuthqDQsPY039QQ@mail.gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Xie He <xie.he.0141@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>

On 2020-12-24 10:49, Xie He wrote:
> On Wed, Dec 23, 2020 at 9:01 AM Xie He <xie.he.0141@gmail.com> wrote:
>> 
>> I don't think this patch is suitable for stable branches. This patch 
>> is
>> part of a patch series that changes the lapb module from "establishing 
>> the
>> L2 connection only when needed by L3", to "establishing the L2 
>> connection
>> automatically whenever we are able to". This is a behavioral change. 
>> It
>> should be seen as a new feature. It is not a bug fix.
> 
> Applying this patch without other patches in the same series will also
> introduce problems, because this patch relies on part of the changes
> in the subsequent patch in the same series to be correct.
> 
> Hi Martin,
> 
> It's better that we avoid using words like "fix" in non-bug-fix
> patches, and make every patch work on its own without subsequent
> patches. Otherwise we'll make people confused.

Yes, you are right.
