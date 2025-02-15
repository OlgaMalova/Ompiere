/**********************************************************************
* This file is part of Ompiere ERP Open Source                      *
* http://www.idempiere.org                                            *
*                                                                     *
* Copyright (C) Contributors                                          *
*                                                                     *
* This program is free software; you can redistribute it and/or       *
* modify it under the terms of the GNU General Public License         *
* as published by the Free Software Foundation; either version 2      *
* of the License, or (at your option) any later version.              *
*                                                                     *
* This program is distributed in the hope that it will be useful,     *
* but WITHOUT ANY WARRANTY; without even the implied warranty of      *
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
* GNU General Public License for more details.                        *
*                                                                     *
* You should have received a copy of the GNU General Public License   *
* along with this program; if not, write to the Free Software         *
* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
* MA 02110-1301, USA.                                                 *
*                                                                     *
* Contributors:                                                       *
* - Trek Global Corporation                                           *
* - Heng Sin Low                                                      *
**********************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.util.Env;
import org.idempiere.cache.ImmutablePOSupport;

/**
 * Lines for MStyle
 * @author hengsin
 */
public class MStyleLine extends X_AD_StyleLine implements ImmutablePOSupport {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -5884961214171382581L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_StyleLine_UU  UUID key
     * @param trxName Transaction
     */
    public MStyleLine(Properties ctx, String AD_StyleLine_UU, String trxName) {
        super(ctx, AD_StyleLine_UU, trxName);
    }

	/**
	 * @param ctx
	 * @param AD_StyleLine_ID
	 * @param trxName
	 */
	public MStyleLine(Properties ctx, int AD_StyleLine_ID, String trxName) {
		super(ctx, AD_StyleLine_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MStyleLine(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	/**
	 * Copy constructor
	 * @param copy
	 */
	public MStyleLine(MStyleLine copy) {
		this(Env.getCtx(), copy);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 */
	public MStyleLine(Properties ctx, MStyleLine copy) {
		this(ctx, copy, (String) null);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MStyleLine(Properties ctx, MStyleLine copy, String trxName) {
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	@Override
	public MStyleLine markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}
