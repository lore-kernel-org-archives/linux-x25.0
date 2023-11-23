Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DAA17E2
	for <linux-x25@vger.kernel.org>; Thu, 23 Nov 2023 02:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pFj5yS58"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89AC7C433C7;
	Thu, 23 Nov 2023 02:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700707359;
	bh=rRbIXqjq8DKBA6vW+7glleky65j8TQodsqrm6IeWtY0=;
	h=Date:From:To:Subject:From;
	b=pFj5yS58sT011v/juRepKSguK9fd/BeOmGMtl1Jx7WfHNYpqUyNnj19/aLVbHBImx
	 JAnMDNZSuFJ7a7axhS3D1bGhQfEJkSPajmV0IkaAcHI1Ez00SHW6Gkm/ActWumP5Tr
	 7ZsFSDi+2X+LeYYzarNwL/MKnnZK7Hf6ScBgKuV4=
Date: Wed, 22 Nov 2023 21:42:38 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: linux-x25@vger.kernel.org
Subject: PSA: this list has moved to new vger infra (no action required)
Message-ID: <20231122-expert-sly-ermine-38f5ad@nitro>
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello, all:

This list has been migrated to the new vger infrastructure. No action is
required on your part and there should be no change in how you interact with
this list.

This message acts as a verification test that the archives are properly
updating.

If something isn't working or looking right, please reach out to
helpdesk@kernel.org.

Best regards,
-K
